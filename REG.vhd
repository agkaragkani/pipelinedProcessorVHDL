----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:20:45 04/05/2023 
-- Design Name: 
-- Module Name:    REG - Behavioral 
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

entity REG is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end REG;

architecture Behavioral of REG is
signal out_signal : STD_LOGIC_VECTOR (31 downto 0);
begin
	
	process
		begin
			wait until CLK'EVENT and CLK = '1' ; 
				if Rst = '1' then
					out_signal <= x"0000_0000" ;
				else
					--out_signal <= WE '1' ? Din : out_signal;
					if WE = '1' then 
						out_signal <= Din ;
					elsif WE = '0' then 
						out_signal <= out_signal; --Keeps its previous value
					end if;
				end if;
	end process;
	Dout <= out_signal; 


end Behavioral;
