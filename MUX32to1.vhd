----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:50:09 04/05/2023 
-- Design Name: 
-- Module Name:    MUX32to1 - Behavioral 
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

package arrayPackage is --package declaration
    type InArray is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0); --create a 32x32bit array as an input for the mux
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.arrayPackage.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX32to1 is
    Port ( Din : in  InArray;
           sel : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32to1;

architecture Behavioral of MUX32to1 is

begin
		with (sel) select 
			    	 Dout <= Din(0) when "00000",
							   Din(1) when "00001",
								Din(2) when "00010",
								Din(3) when "00011",
								Din(4) when "00100",
								Din(5) when "00101",
								Din(6) when "00110",
								Din(7) when "00111",
								Din(8) when "01000",
								Din(9) when "01001",
								Din(10) when "01010",
								Din(11) when "01011",
								Din(12) when "01100",
								Din(13) when "01101",
								Din(14) when "01110",
								Din(15) when "01111",
								Din(16) when "10000",
								Din(17) when "10001",
								Din(19) when "10011",
								Din(20) when "10100",
								Din(21) when "10101",
								Din(22) when "10110",
								Din(23) when "10111",
								Din(24) when "11000",
								Din(25) when "11001",
								Din(26) when "11010",
								Din(27) when "11011",
								Din(28) when "11100",
								Din(29) when "11101",
								Din(30) when "11110",
								Din(31) when others;

end Behavioral;