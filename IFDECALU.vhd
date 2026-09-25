----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:37 04/07/2023 
-- Design Name: 
-- Module Name:    IFDECALU - Behavioral 
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

entity IFDECALU is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           --PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           IFDECALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC;
			  ALU_cout : out STD_LOGIC;
			  ALU_ovf : out STD_LOGIC
			  );
end IFDECALU;

architecture Behavioral of IFDECALU is

component IFDEC is
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
           RF_WrEn : in  STD_LOGIC
			  );
end component;

component ALUSTAGE
    Port(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
			ALU_cout : out STD_LOGIC;
			ALU_ovf : out STD_LOGIC
        );
end component;

signal RF_A_signal, RF_B_signal, immed_signal, ALU_out_Signal : std_logic_vector(31 downto 0);

begin
	
	EX_DATA:ALUSTAGE
		Port map ( RF_A        	  => RF_A_signal, 
				   RF_B        	  => RF_B_signal,
				   Immed		  		  => immed_signal,
				   ALU_Bin_sel 	  => ALU_Bin_sel,
				   ALU_func	      => ALU_func, 
				   ALU_out	      => ALU_out_signal,
					ALU_zero 		=> ALU_zero,
					ALU_cout => ALU_cout,
					ALU_ovf => ALU_ovf 
		);
	IFDEC_IFDECALU:IFDEC 
    Port map ( PC_Sel => PC_Sel,
           PC_LdEn => PC_LdEn,
           CLK => CLK,
           RST => RST,
           --PC_Immed  => PC_Immed,
           RF_WrData_sel => RF_WrData_sel ,
           MEM_OUT => MEM_OUT,
			  ALU_OUT => ALU_out_signal,
           RF_B_sel => RF_B_sel,
           RF_WrEn => RF_WrEn,
			  RF_A => RF_A_signal, 
			  RF_B => RF_B_signal,
			  Immed => immed_signal
		);
		
		IFDECALU_out <= ALU_out_Signal;
end Behavioral;

