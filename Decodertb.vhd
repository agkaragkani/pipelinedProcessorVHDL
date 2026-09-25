--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:06:38 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/Decodertb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
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
 
ENTITY Decodertb IS
END Decodertb;
 
ARCHITECTURE behavior OF Decodertb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         Input : IN  std_logic_vector(4 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          Input => Input,
          Output => Output
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 
		Input<="00000";
		wait for 100ns;
		
		Input<="00001";
		wait for 100ns;
		
		Input<="00010";
		wait for 100ns;
		
		Input<="00011";
		wait for 100ns;
		
		Input<="00100";
		wait for 100ns;
		
		Input<="00101";
		wait for 100ns;
		
		Input<="00110";
		wait for 100ns;
		
		Input<="00111";
		wait for 100ns;
		
		Input<="01000";
		wait for 100ns;
		
		Input<="01001";
		wait for 100ns;
		
		Input<="01010";
		wait for 100ns;
		
		Input<="01011";
		wait for 100ns;
		
		Input<="01100";
		wait for 100ns;
		
		Input<="01101";
		wait for 100ns;
		
		Input<="01110";
		wait for 100ns;
		
		Input<="01111";
		wait for 100ns;
		
		Input<="10000";
		wait for 100ns;
		
		Input<="10001";
		wait for 100ns;
		
		Input<="10010";
		wait for 100ns;
		
		Input<="10011";
		wait for 100ns;
		
		Input<="10100";
		wait for 100ns;
		
		Input<="10101";
		wait for 100ns;
		
		Input<="10110";
		wait for 100ns;
		
		Input<="10111";
		wait for 100ns;
		
		Input<="11000";
		wait for 100ns;
		
		Input<="11001";
		wait for 100ns;
		
		Input<="11010";
		wait for 100ns;
		
		Input<="11011";
		wait for 100ns;
		
		Input<="11100";
		wait for 100ns;
		
		Input<="11101";
		wait for 100ns;
		
		Input<="11110";
		wait for 100ns;
		
		Input<="11111";
		wait for 100ns;

      wait;
   end process;

END;
