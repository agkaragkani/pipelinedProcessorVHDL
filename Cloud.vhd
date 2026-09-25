----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:47:08 04/05/2023 
-- Design Name: 
-- Module Name:    Cloud - Behavioral 
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

entity Cloud is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end Cloud;

architecture Behavioral of Cloud is
SIGNAL SIGNEXTEND : STD_LOGIC_VECTOR(15 DOWNTO 0);

begin

with INSTR(15) select
	SIGNEXTEND <= "0000000000000000" when '0',
					  "1111111111111111" when others;


with Opcode select


	IMMED <= SIGNEXTEND & INSTR(15 DOWNTO 0) WHEN "111000",                     -- li -- sign extention
				INSTR(15 DOWNTO 0) & "0000000000000000" WHEN "111001",             -- lui -- lower zero fill
				SIGNEXTEND & INSTR(15 DOWNTO 0) WHEN "110000",                     -- addi -- sign extention
				"0000000000000000" & INSTR(15 DOWNTO 0) WHEN "110010",             -- andi -- upper zero fill
				"0000000000000000" & INSTR(15 DOWNTO 0) WHEN "110011",             -- ori -- upper zero fill
				SIGNEXTEND(13 DOWNTO 0) & INSTR(15 DOWNTO 0) & "00" WHEN "111111", -- b  -- sign extention & 2sll
				SIGNEXTEND(13 DOWNTO 0) & INSTR(15 DOWNTO 0) & "00" WHEN "010000", -- beq -- sign extention shift left
				SIGNEXTEND(13 DOWNTO 0) & INSTR(15 DOWNTO 0) & "00" WHEN "010001", -- bne -- sign extention shift left
				SIGNEXTEND & INSTR(15 DOWNTO 0) WHEN "000011",                     -- lb -- sign extention
				SIGNEXTEND & INSTR(15 DOWNTO 0) WHEN "000111",                     -- sb -- sign extention
				SIGNEXTEND & INSTR(15 DOWNTO 0) WHEN "001111",                     -- lw -- sign extention
				SIGNEXTEND & INSTR(15 DOWNTO 0) WHEN "011111",                     -- sw -- sign extention
				
				"00000000000000000000000000000000" WHEN OTHERS;

end Behavioral;
