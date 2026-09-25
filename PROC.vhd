----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:51:26 04/06/2023 
-- Design Name: 
-- Module Name:    PROC - Behavioral 
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

entity PROC is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end PROC;

architecture Behavioral of PROC is

component DATAPATH is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           --PC_out : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_zero : out  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC_VECTOR (0 downto 0);
			  sel : in  STD_LOGIC);
end component;

component Control is
    Port ( RST : in  STD_LOGIC;
           Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : in  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           RF_WrEn : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC_VECTOR (0 downto 0);
           PC_LdEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           PC_sel : out  STD_LOGIC;
           Opcode : out  STD_LOGIC_VECTOR (5 downto 0);
			  MEM_sel :  out  STD_LOGIC
			  );
end component;

--component RAMmem port (CLKA : in std_logic;
--								WEA : in std_logic_vector(0 downto 0);
--								ADDRA : in std_logic_vector(9 downto 0);
--								DINA : in std_logic_vector(31 downto 0);
--								DOUTA : out std_logic_vector(31 downto 0));
--end component;

	-- Needed signals
	-- IFSTAGE ---------------------------------------------------------------------------------------------------------------------
	signal IN_PC_sel, IN_PC_LdEn 		 			 : std_logic := '0';
--	signal IN_PC_out								 : std_logic_vector (31 downto 0) := (others => '0');
	-- DECSTAGE --------------------------------------------------------------------------------------------------------------------
	signal IN_RF_WrData_sel, IN_RF_B_sel, IN_RF_WrEn : std_logic := '0';
	-- EXSTAGE ---------------------------------------------------------------------------------------------------------------------
	signal IN_ALU_Bin_sel, IN_ALU_zero				 : std_logic := '0';
	signal IN_ImmExt_s			    				 : std_logic_vector ( 5 downto 0) := (others => '0');
	signal IN_ALU_func 								 : std_logic_vector ( 3 downto 0) := (others => '0');
	-- MEMSTAGE --------------------------------------------------------------------------------------------------------------------
	signal IN_Mem_WrEn : std_logic_vector (0 downto 0) := (others => '0');
	signal IN_Instruction : std_logic_vector (31 downto 0) := (others => '0');
	signal selSignal : std_logic := '0';

begin


CONTROL_PROC :  Control PORT MAP(
			  RST => RST,
           Instruction => IN_Instruction,
           ALU_zero => IN_ALU_zero,
           ALU_Bin_sel => IN_ALU_Bin_sel,
           ALU_func  => IN_ALU_func,
           RF_WrEn  => IN_RF_WrEn,
           MEM_WrEn => IN_Mem_WrEn,     
           PC_LdEn => IN_PC_LdEn,
           RF_B_sel =>  IN_RF_B_sel,
           RF_WrData_sel => IN_RF_WrData_sel,
           PC_sel => IN_PC_sel, 
           Opcode => IN_ImmExt_s,
			  MEM_sel => selSignal
			  );


DATAPATH_PROC : Datapath PORT MAP(  
			  CLK => Clk,
           RST => RST,
           PC_sel => IN_PC_sel,--
           PC_LdEn => IN_PC_LdEn,--
          -- PC_out => IN_PC_out,
           RF_WrData_sel => IN_RF_WrData_sel, --
           RF_B_sel  => IN_RF_B_sel,--
           RF_WrEn => IN_RF_WrEn, --
           Opcode  => IN_ImmExt_s,--
           Instruction  => IN_Instruction, --
           ALU_Bin_sel => IN_ALU_Bin_sel, --
           ALU_func  => IN_ALU_func, --
           ALU_zero => IN_ALU_zero, --
           Mem_WrEn  => IN_Mem_WrEn,--
			  sel  => selSignal--
						);
--						
--RAM_PROC: RAMmem
--		port map ( CLKA     => Clk,
--				   WEA   	 => IN_Mem_WrEn,
--				   ADDRA 	 => IN_PC_out(11 downto 2),
--				   DINA 	 => IN_PC_out,
--				   DOUTA 	 => IN_Instruction
--		);
end Behavioral;
	
