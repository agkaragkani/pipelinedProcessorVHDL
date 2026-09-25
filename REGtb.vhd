--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:21:59 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/REGtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: REG
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
 
ENTITY REGtb IS
END REGtb;
 
ARCHITECTURE behavior OF REGtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         Din : IN  std_logic_vector(31 downto 0);
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal Din : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          Din => Din,
          Dout => Dout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      RST <= '1';
		wait for CLK_period*3/2;													-- 0 - 100ns

      --wait for CLK_period*10;

      -- insert stimulus here 
		-- Dout appears when clock rises 
		
      RST <= '0';
		WE	<= '1';
		Din <= X"0000_ABCD";				
      wait for CLK_period;													-- 100 - 200ns
		
		-- Dout expected to be the same because WE = 0
		WE	<= '0';
      wait for CLK_period;													-- 200 - 300ns	
	   
		-- Dout expected to be the same because we didn't change the value of Din
		WE	<= '1';
      wait for CLK_period;													-- 300 - 400ns
		
		-- Dout expected to change to the new input when clock rises
		Din <= X"ABCD_ABCD";				
		wait for CLK_period;													-- 400 - 500ns
		
		-- Dout expected the same
		WE	<= '0';
		wait for CLK_period;													-- 500 - 600ns
		
		-- Dout expected the same although we change input WE = 0
		Din <= X"1234_7812";				
		wait for CLK_period;													-- 600 - 700ns
		
		-- Dout expected to change to the new input
		WE	<= '1';
		Din <= X"1AB2_164D";				
		wait for CLK_period;													-- 700 - 800ns
		
		-- Dout = 0
		RST <= '1';
		wait for CLK_period;													-- 800 - 900ns

      wait;
   end process;

END;
