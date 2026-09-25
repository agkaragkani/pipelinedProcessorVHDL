----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:20:58 04/05/2023 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
component MUX2_1
   Port ( Din1 : in  STD_LOGIC_VECTOR (31 downto 0);
          Din2 : in  STD_LOGIC_VECTOR (31 downto 0);
          sel : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--32 bit register
component REG
	Port ( CLK : in  STD_LOGIC;
			 WE : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Din : in  STD_LOGIC_VECTOR (31 downto 0);
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

--component ROMmem
--	Port ( CLKA : in STD_LOGIC; 
--			 ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
--			 DOUTA : out STD_LOGIC_VECTOR(31 downto 0));
--end component;


component DistributedRom
	Port ( --clk : in STD_LOGIC; 
			 a : in STD_LOGIC_VECTOR(9 downto 0);
			 spo : out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal incr_out_signal, add_out_signal, mux_out_signal, reg_out_signal: STD_LOGIC_VECTOR (31 downto 0);


begin


IF_REG : REG
port map(
	CLK => CLK,
	WE => PC_LdEn,
   RST => RST,
   Din => mux_out_signal,
   Dout => reg_out_signal
);

IF_MUX : MUX2_1
port map(
	Din1 => incr_out_signal,
   Din2 => add_out_signal,
   sel => PC_sel,
   Dout => mux_out_signal
);


IF_INC : Incrementor
port map(
	Input =>reg_out_signal,
   Output => incr_out_signal
);

IF_ADD : Adder
port map(
	Pc_immed => PC_Immed,
	Incr_input => incr_out_signal,
	Adder_output => add_out_signal
);

--IF_ROM: ROMmem
--	port map(
--	CLKA => CLK,
--	ADDRA => reg_out_signal(11 downto 2),
--	DOUTA=> Instr
--	);


IF_ROM: DistributedRom
	port map(
	--clk=> CLK,
	a => reg_out_signal(11 downto 2),
	spo=> Instr
	);

end Behavioral;
