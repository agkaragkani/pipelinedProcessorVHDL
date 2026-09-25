----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:43:13 04/05/2023 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
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
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component RF
   Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
          Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
          Awr : in  STD_LOGIC_VECTOR (4 downto 0);
			 Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
          Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
          Din : in  STD_LOGIC_VECTOR (31 downto 0);
          WrEn : in  STD_LOGIC;
          CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC
         );
end component;

component MUX2_1
   Port ( Din1 : in  STD_LOGIC_VECTOR (31 downto 0);
          Din2 : in  STD_LOGIC_VECTOR (31 downto 0);
          sel : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Cloud
   Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
			 Opcode: in  STD_LOGIC_VECTOR (5 downto 0);
          Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX2_1_5bit 
    Port ( Din1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Din2 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

signal dec_out : STD_LOGIC_VECTOR (1 downto 0);
signal mux_out_5bit : STD_LOGIC_VECTOR (4 downto 0);
signal mux_out : STD_LOGIC_VECTOR (31 downto 0);

begin
 
DEC_MUX_5bit: MUX2_1_5bit
port map(
	Din1 => Instr(15 downto 11), --rt		
   Din2 => Instr(20 downto 16), --rd	
   sel => RF_B_sel,
   Dout => mux_out_5bit
);

DEC_MUX: MUX2_1
port map(
	Din1 => ALU_out,
   Din2 => MEM_out,
   sel => RF_WrData_sel,
   Dout => mux_out
);

DEC_RF: RF
port map(
	Ard1 => Instr(25 downto 21),		-- address of first read register 
   Ard2 => mux_out_5bit,				-- address of second read register
   Awr => Instr(20 downto 16),		-- address of write register 
	Dout1 => RF_A,							-- output of first register
   Dout2 => RF_B,							-- output of second register
   Din => mux_out,						-- data to store
   WrEn => RF_WrEn,						-- enable writw register 
   CLK => CLK, 
   RST => RST
);


DEC_CLOUD: Cloud
port map(
	Instr => Instr(15 downto 0),
   Opcode => Instr(31 downto 26),
   Immed => DecImmed
);
end Behavioral;

