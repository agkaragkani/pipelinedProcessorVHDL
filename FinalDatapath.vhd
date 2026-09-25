----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:23:34 04/15/2023 
-- Design Name: 
-- Module Name:    FinalDatapath - Behavioral 
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

entity FinalDatapath is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : in  STD_LOGIC;
           MEM_sel : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC;
           ALU_cout : out  STD_LOGIC;
           ALU_ovf : out  STD_LOGIC;
           MEM_Data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end FinalDatapath;

architecture Behavioral of FinalDatapath is

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

component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_cout : out  STD_LOGIC;
			  ALU_ovf : out  STD_LOGIC
			  );
end component;

component MEMSTAGE is
    Port ( CLK : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MEM_WrEn : in  STD_LOGIC;
			  sel: in STD_LOGIC);
end component;

signal Instr_signal, Immed_signal, ALU_out_signal, MEM_out_signal, RF_A_signal, RF_B_signal: std_logic_vector (31 downto 0) := (others => '0');

begin

	DATAIF: IFSTAGE 
		PORT MAP (
          PC_Immed => Immed_signal,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          RST => RST,
          CLK => CLK,
          Instr => Instr_signal
        );
		  
	DATADEC: DECSTAGE 
		PORT MAP (
          Instr => Instr_signal,  
          RST => RST,
          CLK => CLK,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out_signal,
          MEM_out => MEM_out_signal,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          DecImmed => Immed_signal,
          RF_A => RF_A_signal ,
          RF_B => RF_B_signal 
        );
		  
	DATAALU: ALUSTAGE 
		 PORT MAP (
          RF_A => RF_A_signal,
          RF_B => RF_B_signal,
          Immed => Immed_signal,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out_signal,
          ALU_zero => ALU_zero,
			 ALU_cout => ALU_cout,
			 ALU_ovf => ALU_ovf
        );
	DATAMEM: MEMSTAGE 
		PORT MAP (
          CLK => CLK,
          ALU_MEM_Addr => ALU_out_signal ,
          MEM_DataIn => RF_B_signal,
          MEM_DataOut => MEM_out_signal,
          MEM_WrEn => MEM_WrEn,
			 sel => Mem_sel
        );
		  
Instr <= Instr_signal;
MEM_Data_out <= MEM_out_signal;
end Behavioral;

