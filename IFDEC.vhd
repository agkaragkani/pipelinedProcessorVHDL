----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:26:51 04/07/2023 
-- Design Name: 
-- Module Name:    IFDEC - Behavioral 
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

entity IFDEC is
    Port ( PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           --PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_OUT : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC);
end IFDEC;

architecture Behavioral of IFDEC is

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
           CLK : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           DecImmed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal instrSignal, immedSignal : STD_LOGIC_VECTOR (31 downto 0);


begin

	IF_DATA:IFSTAGE
		port map ( PC_sel   	  => PC_sel, 
				   PC_LdEn  	  => PC_LdEn,
				  -- PC_Immed 	  => PC_Immed,
				   PC_Immed 	  => immedSignal,
					RST		  	  => Rst,
				   CLK      	  => Clk,                   
				   Instr        => instrSignal                  
		);

----------------------------------------------------- DECSTAGE ------------------------------------------------------
	DEC_DATA:DECSTAGE
		port map ( RF_WrEn        => RF_WrEn, 
				   RF_WrData_sel  => RF_WrData_sel,
				   RF_B_sel       => RF_B_sel,               
				   Instr 		  => instrSignal,
				   Clk            => Clk,
				   Rst            => Rst,    
				   ALU_out		  => ALU_out,
				   MEM_out 	      => MEM_out,
				   DecImmed 		  => immedSignal,
					--DecImmed 		  => Immed,
				   RF_A			  => RF_A,
				   RF_B			  => RF_B					
		);

	Immed <= immedSignal;
end Behavioral;

