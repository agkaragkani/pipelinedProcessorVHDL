--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:05:59 04/14/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/CLOUDtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Cloud
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
 
ENTITY CLOUDtb IS
END CLOUDtb;
 
ARCHITECTURE behavior OF CLOUDtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cloud
    PORT(
         Instr : IN  std_logic_vector(15 downto 0);
         Opcode : IN  std_logic_vector(5 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(15 downto 0) := (others => '0');
   signal Opcode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cloud PORT MAP (
          Instr => Instr,
          Opcode => Opcode,
          Immed => Immed
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

     -- wait for <clock>_period*10;

      -- insert stimulus here 
		-- Instr <= "111000 00001 00010 0000111100001111

		-- li : sign extention
		Instr <= "0000111100001111";
		Opcode <= "111000";
		wait for 100 ns;
		
		-- lui : lower zerofill 
		Opcode <= "111001";
		wait for 100 ns;
		
		-- addi : sign extention
		Opcode <= "110000";
		wait for 100 ns;
		
		-- andi : upper zerofill
      Opcode <= "110010";
		wait for 100 ns;
		
		-- ori : upper zerofill
		Opcode <= "110011";
		wait for 100 ns;
		
		-- b : sign extention & 2sll
		Opcode <= "111111";
		wait for 100 ns;
		
		-- beq : sign extention & 2sll
		Opcode <= "010000";
		wait for 100 ns;
		
		-- bne : sign extention & 2sll
		Opcode <= "010001";
		wait for 100 ns;
		
		-- lb : sign extention
		Opcode <= "000011";
		wait for 100 ns;
		
		-- sb : sign extention
		Opcode <= "000111";
		wait for 100 ns;
		
		-- lw : sign extention
		Opcode <= "001111";
		wait for 100 ns;
		
		-- sw : sign extention
		Opcode <= "011111";
		wait for 100 ns;
		
		wait;
   end process;

END;
