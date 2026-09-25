--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:09:16 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/Comparatortb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comparator
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
 
ENTITY Comparatortb IS
END Comparatortb;
 
ARCHITECTURE behavior OF Comparatortb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comparator
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Ard : IN  std_logic_vector(4 downto 0);
         equalFlag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal equalFlag : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comparator PORT MAP (
          Awr => Awr,
          Ard => Ard,
          equalFlag => equalFlag
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
		-- equal so equalFlag is expected to be 1
		Awr<="10101";
		Ard<="10101";
		wait for 100ns;
		
		-- not equal so equalFlag is expected to be 0
		Awr<="10101";
		Ard<="10100";
		wait for 100ns;
		
		-- not equal
		Awr<="00000";
		Ard<="11111";
		wait for 100ns;
		
		-- equal
		Awr<="00000";
		Ard<="00000";
		wait for 100ns;

      wait;
   end process;

END;
