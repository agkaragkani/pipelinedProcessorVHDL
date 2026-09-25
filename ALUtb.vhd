--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:17:53 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/ALUtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALUtb IS
END ALUtb;
 
ARCHITECTURE behavior OF ALUtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
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
		
		--- add --- 
		
		-- 0. zero --
		Op<="0000";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		-- 1. overflow --
		
		Op<="0000";
		A<=x"0001_0000";
		B<=x"7fff_0000";
		wait for 100ns;
		
		-- 2. carry out -- 
		Op<="0000";
		A<=x"ff00_0000";
		B<=x"ff00_0000";
		wait for 100 ns;
		
		-- 3. overflow and carry out -- 
		Op<="0000";
		A<=x"8888_0000";
		B<=x"8888_0000";
		wait for 100 ns;
		
		-- 4. nothing -- 
		
		Op<="0000";
		A<=x"8000_a0b0";
		B<=x"0010_abcd";
		wait for 100 ns;
		
		--- sub ---
		
		-- 5. zero --
		Op<="0001";
		A<=x"acdc_acdc";
		B<=x"acdc_acdc";
		wait for 100 ns;
		
		-- 6. overflow --
		Op<="0001";
		A<=x"8000_0000";
		B<=x"3000_ffff";
		wait for 100 ns;

		-- 7. carry out -- 
		Op<="0001";		
		A<=x"0000_0000";
		B<=x"7fff_ffff";
		wait for 100 ns;
		
		-- 8. overflow and carry out -- 
		Op<="0001";
		A<=x"7fff_ffff";
		B<=x"f000_0000";
		wait for 100 ns;
		
		-- 9. nothing --
		Op<="0001";
		A<=x"7acc_b000";
		B<=x"20c0_8400";
		wait for 100 ns;

		--- and ---
		
		-- 10. zero -- 
		Op<="0010";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		-- 11. zero (non zero inputs) --
		Op<="0010";
		A<=x"aaaa_aaaa";
		B<=x"5555_5555";
		wait for 100 ns;
		
		-- 12. nothing -- 
		Op<="0010";
		A<=x"ffff_ffff";
		B<=x"ffff_ffff";
		wait for 100 ns;		

		--- or ---
		
		-- 13. zero -- 
		Op<="0011";
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		-- 14. nothing -- 
		Op<="0011";
		A<=x"aaaa_aaaa";
		B<=x"5555_5555";
		wait for 100 ns;
		
		-- 15. nothing -- 
		Op<="0011";
		A<=x"ffff_ffff";
		B<=x"ffff_ffff";
		wait for 100 ns;	
		
		--- not ---
		
		-- 16. nothing --
		Op<="0100";
		A<=x"0000_0000";
		wait for 100 ns;
		
		-- 17. nothing --
		Op<="0100";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		-- 18. zero --
		Op<="0100";
		A<=x"ffff_ffff";
		wait for 100 ns;	
		
		--- sra ---
		
		-- 19. zero --
		Op<="1000";
		A<=x"0000_0000";
		wait for 100 ns;
		
		-- 20. nothing --
		Op<="1000";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		-- 21. nothing --
		Op<="1000";
		A<=x"7fff_ffff";
		wait for 100 ns;	
		
		--- srl ---
		
		-- 22. zero --
		Op<="1001";
		A<=x"0000_0000";
		wait for 100 ns;
		
		-- 23. nothing --
		Op<="1001";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		-- 24. nothing --
		Op<="1001";
		A<=x"ffff_ffff";
		wait for 100 ns;	
		
		--- sll ---
		
		-- 25. zero --
		Op<="1010";
		A<=x"0000_0000";
		wait for 100 ns;
		
		-- 26. nothing --
		Op<="1010";
		A<=x"aaaa_aaaa";
		wait for 100 ns;
		
		-- 27. nothing --
		Op<="1010";
		A<=x"ffff_ffff";
		wait for 100 ns;				

		--- left rotation ---
		
		-- 28. nothing --
		Op<="1100";
		A<=x"8000_0001";
		wait for 100 ns;
		
		-- 29. zero --
		Op<="1100";
		A<=x"0000_0000";
		wait for 100 ns;
		
		-- 30. nothing --
		Op<="1100";
		A<=x"f000_0000";
		wait for 100 ns;
		
		--- right rotation ---
		
		-- 31. nothing --
		Op<="1101";
		A<=x"8000_0001";
		wait for 100 ns;
		
		-- 32. zero --
		Op<="1101";
		A<=x"0000_0000";
		wait for 100 ns;
		
		-- 33. nothing --
		Op<="1101";
		A<=x"0000_000f";
		wait for 100 ns;			
		
		--- non valid ---
		
		-- 34. zero --
		Op<="1111";
		A<=x"abcd_1234";
		B<=x"abcd_1234";
		wait for 100 ns;
		
		-- 35. zero --
		Op<="1110";
		A<=x"abcd_1234";
		B<=x"abcd_1234";
		wait for 100 ns;
		
		-- 36. zero --
		Op<="0111";
		A<=x"abcd_1234";
		B<=x"abcd_1234";
		wait for 100 ns;

      wait;
   end process;

END;
