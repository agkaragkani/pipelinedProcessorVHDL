--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:07:37 04/13/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/MUX5bit_tb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX2_1_5bit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MUX5bit_tb IS
END MUX5bit_tb;
 
ARCHITECTURE behavior OF MUX5bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX2_1_5bit
    PORT(
         Din1 : IN  std_logic_vector(4 downto 0);
         Din2 : IN  std_logic_vector(4 downto 0);
         sel : IN  std_logic;
         Dout : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Din2 : std_logic_vector(4 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2_1_5bit PORT MAP (
          Din1 => Din1,
          Din2 => Din2,
          sel => sel,
          Dout => Dout
        );

	-- Clock process definitions
	--   <clock>_process :process
	--   begin
	--		<clock> <= '0';
	--		wait for <clock>_period/2;
	--		<clock> <= '1';
	--		wait for <clock>_period/2;
	--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 
		Din1<="00001";
		Din2<="10101";
		sel<='0';
		wait for 100ns;
		
		sel<='1';
		wait for 100ns;
		
		Din1<="11111";
		Din2<="10001";
		wait for 100ns;
		
		Din1<="10101";
		Din2<="01010";
		wait for 100ns;
		
		sel<='0';
		wait for 100ns;

      wait;
   end process;

END;
