----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:20:44 06/01/2023 
-- Design Name: 
-- Module Name:    PIPELINE_IFSTAGE - Behavioral 
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

entity PIPELINE_IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end PIPELINE_IFSTAGE;

architecture Behavioral of PIPELINE_IFSTAGE is
component MUX2_1
   Port ( Din1 : in  STD_LOGIC_VECTOR (31 downto 0);
          Din2 : in  STD_LOGIC_VECTOR (31 downto 0);
          sel : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--32 bit register
component REG
	Port ( CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Din : in  STD_LOGIC_VECTOR (31 downto 0);
          WE : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Incrementor
	Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
          Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Adder
	Port ( Pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
          Incr_input : in  STD_LOGIC_VECTOR (31 downto 0);
          Adder_output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component rompipeline
	Port ( --clk : in STD_LOGIC; 
			 a : in STD_LOGIC_VECTOR(9 downto 0);
			 spo : out STD_LOGIC_VECTOR(31 downto 0));
end component;


signal inc_out, addToMux, mux_out, PC_out: STD_LOGIC_VECTOR (31 downto 0);

begin
Add : Adder
port map(
	Pc_immed => PC_Immed,
	Incr_input => PC_out,
	Adder_output => addToMux
);

mux : MUX2_1
port map(
	Din1 => inc_out,
   Din2 => addToMux,
   sel => PC_sel,
   Dout => mux_out
);

PC_reg : REG
port map(
	CLK => Clk,
   RST => Reset,
   Din => mux_out,
   WE => PC_LdEn,
   Dout => PC_out
);

Incr_4 : Incrementor
port map(
	Input =>PC_out,
   Output => inc_out
);



IF_ROM: rompipeline
	port map(
	--clk=> CLK,
	a => PC_out(11 downto 2),
	spo=> Instr
	);

--Instr <= PC_out;

end Behavioral;


