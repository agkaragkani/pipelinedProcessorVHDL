----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:49 04/05/2023 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use work.arrayPackage.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is

component Decoder
	port (Input : IN  std_logic_vector(4 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
			);
end component;
	
component REG
	port(CLK : in  STD_LOGIC;
		  WE : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        Din : in  STD_LOGIC_VECTOR (31 downto 0);
        Dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
	
component MUX32to1
		port(Din : in InArray;
			sel : in  STD_LOGIC_VECTOR (4 downto 0);
			Dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component MUX2_1
	port(Din1 : in  STD_LOGIC_VECTOR (31 downto 0);
        Din2 : in  STD_LOGIC_VECTOR (31 downto 0);
        sel : in  STD_LOGIC;
        Dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
	
component Comparator
	port(Awr : in  STD_LOGIC_VECTOR (4 downto 0);
        Ard : in  STD_LOGIC_VECTOR (4 downto 0);
        equalFlag : out  STD_LOGIC
	);
end component;

signal decoder_out_signal, andGate_out_signal, muxA_in, muxB_in: STD_LOGIC_VECTOR (31 downto 0);
signal comparatorA_signal, comparatorB_signal, selA, selB : STD_LOGIC;
--type register_out_signal is array (31 downto 0) of std_logic_vector(31 downto 0);  -- an array 32x32 that holds  32 output bits from 32 registers
signal register_out_signal : InArray;


begin
RF_DEC : Decoder
port map(
	Input => Awr,
   Output => decoder_out_signal
);


-- Creating 31 registers
RF_REG:
for i in 0 to 31 generate
	andGate_out_signal(i) <= decoder_out_signal(i) AND WrEn;
	RF_REG0: 
	if i=0 generate								
			RF_R0: REG 
				port map( CLK      => CLK,
						  RST      => RST,
						  WE  	   => '1',
						  Din   => "00000000000000000000000000000000",
						  Dout  => register_out_signal(i)			
				);
	end generate RF_REG0;
	
	RF_REGs: 
	if i>0 generate
		RF_R: REG
			port map(CLK => CLK,
						WE => andGate_out_signal(i),
						RST => RST,
						Din => Din,
						Dout => register_out_signal(i)
			);
	end generate RF_REGs;
end generate RF_REG; 

RF_MUX32_A : Mux32to1
port map(
		Din => register_out_signal,
		sel => Ard1,
      Dout => muxA_in
		);
		

RF_MUX32_B : Mux32to1
port map(
		Din => register_out_signal,
		sel => Ard2,
      Dout => muxB_in
		);
		  
RF_COMP_A: Comparator
port map(Awr => Awr,
         Ard => Ard1, 
         equalFlag => comparatorA_signal
);

RF_COMP_B: Comparator
port map(Awr => Awr,
         Ard => Ard2, 
         equalFlag => comparatorB_signal
);

selA <= comparatorA_signal AND WrEn;
selB <= comparatorB_signal AND WrEn;

RF_MUX2_A: MUX2_1
port map(Din1 => muxA_in,  
         Din2 => Din, 
         sel => selA,
         Dout => Dout1
			--Dout => muxA
);

RF_MUX2_B: MUX2_1
port map(Din1 => muxB_in,  
         Din2 => Din, 
         sel => selB,
         Dout => Dout2
		  --Dout =>muxB
);
end Behavioral;
