----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:29 04/06/2023 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
          -- PC_out : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in STD_LOGIC_VECTOR (3 downto 0);
           ALU_zero : out  STD_LOGIC;
           MEM_WrEN : in  STD_LOGIC_VECTOR (0 downto 0);
			  sel : in  STD_LOGIC);
end DATAPATH;

architecture Behavioral of DATAPATH is

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RST : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DecImmed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end component;

component MEMSTAGE is
    Port ( CLK : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MEM_WrEN : in  STD_LOGIC_VECTOR (0 downto 0);
			  sel: in STD_LOGIC);
end component;

-- Needed signals
-- DECSTAGE SIGNAL ----------------------------------------------------------------------------------
	signal busA, busB 							: std_logic_vector (31 downto 0) := (others => '0');
	signal IN_ALU_out, IN_MEM_out, IN_IMMED_OUT : std_logic_vector (31 downto 0) := (others => '0');
	signal PC_out_signal: std_logic_vector (31 downto 0) := (others => '0');


-------------------------------------------------- Main Functions --------------------------------------------------                                                                                        
begin
----------------------------------------------------- IFSTAGE ------------------------------------------------------
	IF_DATA:IFSTAGE
		port map ( PC_sel   	  => PC_sel, 
				   PC_LdEn  	  => PC_LdEn,
				   PC_Immed 	  => IN_IMMED_OUT,
				   RST		  	  => Rst,
				   CLK      	  => Clk,                   
				   Instr        => PC_out_signal                  
		);

----------------------------------------------------- DECSTAGE ------------------------------------------------------
	DEC_DATA:DECSTAGE
		port map ( RF_WrEn        => RF_WrEn, 
				   RF_WrData_sel  => RF_WrData_sel,
				   RF_B_sel       => RF_B_sel,               
				--   immExt         => ImmExt_s,
				  -- Instr 		  => Instruction,
					Instr 		  => PC_out_signal,
				   Clk            => Clk,
				   Rst            => Rst,    
				   ALU_out		  => IN_ALU_out,
				   MEM_out 	      => IN_MEM_out,
				   DecImmed 		  => IN_IMMED_out,
				   RF_A			  => busA,
				   RF_B			  => busB					
		);
		
----------------------------------------------------- EXSTAGE ------------------------------------------------------
	EX_DATA:ALUSTAGE
		Port map ( RF_A        	  => busA, 
				   RF_B        	  => busB,
				   Immed		  => IN_IMMED_out,
				   ALU_Bin_sel 	  => ALU_Bin_sel,
				   ALU_func	      => ALU_func, 
				   ALU_out	      => IN_ALU_out,
               ALU_zero       => ALU_zero
				 --  ALU_cout	      => ALU_cout,
				  -- ALU_ovf        => ALU_ovf
		);

----------------------------------------------------- MEMSTAGE -----------------------------------------------------
	MEM_DATA:MEMSTAGE
		Port map( --ByteOp          => ByteOp,
					Clk	      => Clk,
				  Mem_WrEn	      => Mem_WrEn,
				  ALU_MEM_Addr    => IN_ALU_out,
				  MEM_DataIn      => busB,
--				  MM_RdData       => MM_RdData, 
--				  MM_WrEn         => MM_WrEn,
--				  MM_Addr         => MM_Addr,
--				  MM_WrData       => MM_WrData,
				  MEM_DataOut     => IN_MEM_out,
				  sel => sel
		);
		
		--PC_out <= PC_out_signal;
	
end Behavioral;



