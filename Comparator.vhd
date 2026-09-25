----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:58:51 04/05/2023 
-- Design Name: 
-- Module Name:    Comparator - Behavioral 
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

entity Comparator is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           equalFlag : out  STD_LOGIC);
end Comparator;

architecture Behavioral of Comparator is
signal equal_signal : STD_LOGIC;

-- a simple comparator that checks if two 5-bit inputs are equal
begin
process (Awr,Ard)
begin
	-- if Awr = Ard = 00000 then equalSignal=0 so that
	-- output of R0 cannot be changed, see code in RF
	if (Awr=Ard AND (Awr /= "00000")) then
		equal_signal<='1';
	--elsif (Awr="00000") then
	--	equal_signal<='0';
	else
		equal_signal<='0';
	end if;
end process;
	equalFlag<=equal_signal;

--equalFlag<='0' when (Awr/=Ard)  else '1';
end Behavioral;
