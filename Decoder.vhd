----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:46:09 04/05/2023 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( Input : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal output_signal :STD_LOGIC_VECTOR (31 downto 0);

begin
	with (Input) select
		output_signal <= x"0000_0001" when "00000",
						  x"0000_0002" when "00001",
						  x"0000_0004" when "00010",
						  x"0000_0008" when "00011",
						  x"0000_0010" when "00100",
						  x"0000_0020" when "00101",
						  x"0000_0040" when "00110",
						  x"0000_0080" when "00111",
						  x"0000_0100" when "01000",
						  x"0000_0200" when "01001",
						  x"0000_0400" when "01010",
						  x"0000_0800" when "01011",
						  x"0000_1000" when "01100",
						  x"0000_2000" when "01101",
						  x"0000_4000" when "01110",
						  x"0000_8000" when "01111",
						  x"0001_0000" when "10000",
						  x"0002_0000" when "10001",
						  x"0004_0000" when "10010",
						  x"0008_0000" when "10011",
						  x"0010_0000" when "10100",
						  x"0020_0000" when "10101",
						  x"0040_0000" when "10110",
						  x"0080_0000" when "10111",
						  x"0100_0000" when "11000",
						  x"0200_0000" when "11001",
						  x"0400_0000" when "11010",
						  x"0800_0000" when "11011",
						  x"1000_0000" when "11100",
						  x"2000_0000" when "11101",
						  x"4000_0000" when "11110",
						  x"8000_0000" when "11111",
						  x"0000_0000" when others;
						
	Output<= output_signal;
end Behavioral;

