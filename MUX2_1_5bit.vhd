----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:45:52 04/05/2023 
-- Design Name: 
-- Module Name:    MUX2_1_5bit - Behavioral 
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

entity MUX2_1_5bit is
    Port ( Din1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Din2 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX2_1_5bit;

architecture Behavioral of MUX2_1_5bit is

signal Output_sig : STD_LOGIC_VECTOR (4 downto 0);

begin

	Output_sig <= Din1 when sel = '0' else
					  Din2; --when sel = '1';

					  
	Dout <= Output_sig;

end Behavioral;

