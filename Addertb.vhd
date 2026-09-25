--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:31:58 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/Addertb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Adder
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
 
ENTITY Addertb IS
END Addertb;
 
ARCHITECTURE behavior OF Addertb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder
    PORT(
         PC_immed : IN  std_logic_vector(31 downto 0);
         Incr_input : IN  std_logic_vector(31 downto 0);
         Adder_output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_immed : std_logic_vector(31 downto 0) := (others => '0');
   signal Incr_input : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Adder_output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder PORT MAP (
          PC_immed => PC_immed,
          Incr_input => Incr_input,
          Adder_output => Adder_output
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
		-- Initialize inputs
      PC_immed <= "00000000000000000000000000000001";
      Incr_input <= "00000000000000000000000000000010";

      -- Wait for 10 ns to allow inputs to stabilize
      wait for 100 ns;


      wait;
   end process;

END;
