----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:45:16 04/15/2023 
-- Design Name: 
-- Module Name:    FINALPROC - Behavioral 
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

entity FINALPROC is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end FINALPROC;

architecture Behavioral of FINALPROC is

	 COMPONENT FinalDatapath
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN  std_logic;
         MEM_sel : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
         ALU_cout : OUT  std_logic;
         ALU_ovf : OUT  std_logic;
         MEM_Data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT CONTROL
    PORT(
         RST : IN  std_logic;
         Instruction : IN  std_logic_vector(31 downto 0);
         ALU_zero : IN  std_logic;
         ALU_Bin_sel : OUT  std_logic; --
         ALU_func : OUT  std_logic_vector(3 downto 0);
         RF_WrEn : OUT  std_logic;
         MEM_WrEn : OUT  std_logic; --
         PC_LdEn : OUT  std_logic; --
         RF_B_sel : OUT  std_logic; --
         RF_WrData_sel : OUT  std_logic; --
         PC_sel : OUT  std_logic; --
         Opcode : OUT  std_logic_vector(5 downto 0); --
			MEM_sel : OUT  std_logic
        );
    END COMPONENT;
	 
-- Needed signals

signal IN_PC_sel, IN_PC_LdEn, IN_RF_WrData_sel, IN_RF_B_sel, IN_RF_WrEn, IN_ALU_Bin_sel, IN_ALU_zero, IN_ALU_cout,IN_ALU_ovf,selSignal : std_logic := '0';

	-- IFSTAGE ---------------------------------------------------------------------------------------------------------------------
	--signal IN_PC_sel, IN_PC_LdEn 		 			 : std_logic := '0';
--	signal IN_PC_out								 : std_logic_vector (31 downto 0) := (others => '0');
	-- DECSTAGE --------------------------------------------------------------------------------------------------------------------
	--signal IN_RF_WrData_sel, IN_RF_B_sel, IN_RF_WrEn : std_logic := '0';
	-- EXSTAGE ---------------------------------------------------------------------------------------------------------------------
	--signal IN_ALU_Bin_sel, IN_ALU_zero				 : std_logic := '0';
	signal IN_Opcode			    				 : std_logic_vector ( 5 downto 0) := (others => '0');
	signal IN_ALU_func 								 : std_logic_vector ( 3 downto 0) := (others => '0');
	-- MEMSTAGE --------------------------------------------------------------------------------------------------------------------
	signal IN_Mem_WrEn : std_logic := '0';
	signal IN_Instruction, IN_MEM_Data_out : std_logic_vector (31 downto 0) := (others => '0');
	--signal selSignal : std_logic := '0';

begin

	PROCDATAPATH: FinalDatapath 
	PORT MAP (
          CLK => CLK,
          RST => RST,
          PC_sel => IN_PC_sel,
          PC_LdEn => IN_PC_LdEn,
          RF_WrEn => IN_RF_WrEn,
          RF_WrData_sel => IN_RF_WrData_sel,
          RF_B_sel => IN_RF_B_sel,
          ALU_Bin_sel => IN_ALU_Bin_sel,
          ALU_func => IN_ALU_func ,
          MEM_WrEn => IN_Mem_WrEn,
          MEM_sel => selSignal,
          Instr => IN_Instruction,
          ALU_zero => IN_ALU_zero,
          ALU_cout => IN_ALU_cout,
          ALU_ovf => IN_ALU_ovf,
          MEM_Data_out => IN_MEM_Data_out
        );
		  
	PROCCONTROL: CONTROL PORT MAP (
          RST => RST,
          Instruction => IN_Instruction,
          ALU_zero => IN_ALU_zero,
          ALU_Bin_sel => IN_ALU_Bin_sel,
          ALU_func => IN_ALU_func ,
          RF_WrEn => IN_RF_WrEn,
          MEM_WrEn => IN_Mem_WrEn,
          PC_LdEn => IN_PC_LdEn,
          RF_B_sel => IN_RF_B_sel,
          RF_WrData_sel => IN_RF_WrData_sel,
          PC_sel => IN_PC_sel,
          Opcode => IN_Opcode	,
			 MEM_sel => selSignal  
        );
		  
	IN_Opcode <= IN_Instruction(31 downto 26);

end Behavioral;

