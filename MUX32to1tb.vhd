--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:52:16 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/MUX32to1tb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX32to1
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
use work.arrayPackage.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MUX32to1tb IS
END MUX32to1tb;
 
ARCHITECTURE behavior OF MUX32to1tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX32to1
    PORT(
         Din : IN  InArray;
         sel : IN  std_logic_vector(4 downto 0);
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : InArray := (others => (others => '0'));
   signal sel : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX32to1 PORT MAP (
          Din => Din,
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

		Din(0) <= "00000000000000000000000000000000";  
		Din(1) <= "00000000000000000000000000000001";  
		Din(2) <= "00000000000000000000000000000010";  
		Din(3) <= "00000000000000000000000000000011";  
		
		Sel <= "00000";								  -- Selecting the first input
		wait for 100 ns;								  

		Sel <= "00001";								  -- Selecting the second input
		wait for 100 ns;								  

		Sel <= "00010";								  -- Selecting the third input
		wait for 100 ns;								  

		Sel <= "00011";								  -- Selecting the forth input
		wait for 100 ns;								  

		
		Din(0) <= "00000000001111110001100001000000";  
		Din(1) <= "11111111111111111111111111111111";  
		Din(2) <= "10101010101010101010101010101010";  
		Din(3) <= "00100101101110001110010110101010";  

		Sel <= "00000";								  -- Selecting the first input
		wait for 100 ns;								 
		 		
		Sel <= "00001";								  -- Selecting the second input
		wait for 100 ns;								  
		 
		Sel <= "00010";								  -- Selecting the third input
		wait for 100 ns;								  

		Sel <= "00011";								  -- Selecting the forth input
		wait for 100 ns;								  		

      wait;
   end process;

END;
