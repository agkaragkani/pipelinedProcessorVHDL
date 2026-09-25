--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:57:28 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/ALUSTAGEtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUSTAGE
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
USE ieee.std_logic_unsigned.all; 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALUSTAGEtb IS
END ALUSTAGEtb;
 
ARCHITECTURE behavior OF ALUSTAGEtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
			ALU_cout : out  STD_LOGIC;
			ALU_ovf : out  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
	signal ALU_cout : std_logic;
	signal ALU_ovf : std_logic;
	-- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero,
			 ALU_cout => ALU_cout,
			 ALU_ovf => ALU_ovf
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
		RF_A <= x"0000_0001";
		RF_B <= x"0000_ABCD";
		Immed <= X"0BCD_AC01";
		ALU_Bin_sel <= '0'; -- Choosing the RF_B as the second ALU input
		ALU_func <= "0000"; -- Addition
      wait for 100 ns; 
			
		ALU_Bin_sel <= '1'; -- Choosing the Immed as the second ALU input
		ALU_func <= "0001"; -- Subtraction
      wait for 100 ns; 
			
		ALU_func <= "0100"; -- not A
      wait for 100 ns; 
			
		ALU_Bin_sel <= '0';
		ALU_func <= "0010"; -- A and B 
      wait for 100 ns; 
			
		ALU_Bin_sel <= '1';
		ALU_func <= "0011";
		wait for 100 ns; -- A or Immed
		
		ALU_func <= "1000";
		wait for 100 ns; --sra
		
		for i in 0 to 1 loop	-- srl and sll
			Immed <= X"0000_ffff";
			RF_A <= RF_A + b"1";
			RF_B <= RF_B + b"1";
			ALU_func <= ALU_func + b"1";
			wait for 100 ns;
		end loop;
			
		ALU_func <= "1100"; -- ror
		wait for 100 ns;
		
		ALU_func <= "1101"; -- rol
		wait for 100 ns;

      wait;
   end process;

END;
