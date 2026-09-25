--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:48:42 04/06/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/CONTROLtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROLtb IS
END CONTROLtb;
 
ARCHITECTURE behavior OF CONTROLtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         RST : IN  std_logic;
         Instruction : IN  std_logic_vector(31 downto 0);
         ALU_zero : IN  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         RF_WrEn : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_B_sel : OUT  std_logic; 
         RF_WrData_sel : OUT  std_logic; 
         PC_sel : OUT  std_logic; 
         Opcode : OUT  std_logic_vector(5 downto 0); 
			MEM_sel : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_zero : std_logic := '0';

 	--Outputs
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal RF_WrEn : std_logic;
   signal MEM_WrEn : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal PC_sel : std_logic;
   signal Opcode : std_logic_vector(5 downto 0);
	signal MEM_sel :  std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          RST => RST,
          Instruction => Instruction,
          ALU_zero => ALU_zero,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          RF_WrEn => RF_WrEn,
          MEM_WrEn => MEM_WrEn,
          PC_LdEn => PC_LdEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          PC_sel => PC_sel,
          Opcode => Opcode,
			 MEM_sel =>  MEM_sel
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
		Rst <= '1';
		wait for 100 ns;	-- 0 - 100ns

      --wait for <clock>_period*10;

      -- insert stimulus here 
		Rst <= '0';
		
		--Opcode <= Instruction(31 downto 26);
		
		Instruction(31 downto 26) <= "100000";	-- R type
		Instruction(25 downto  6) <= x"00000";	-- don't care
		--ALU_zero <= '0'; 								
		
		Instruction( 5 downto  0) <= "110000";  -- Func (Addition)
		wait for 100 ns;								-- 100 -200 ns
		
		Instruction( 5 downto  0) <= "110001";	-- Func (Subtraction)
		wait for 100 ns;								-- 200 - 300 ns
		
		Instruction( 5 downto  0) <= "110010";	-- Func (And)
		wait for 100 ns;								-- 300 -- 400 ns
		
		Instruction( 5 downto  0) <= "110011";	-- Func (or)
		wait for 100 ns;								-- 400 - 500ns
		
		Instruction( 5 downto  0) <= "110100";	-- Func (not)
		wait for 100 ns;								-- 500 - 600 ns
		
		Instruction( 5 downto  0) <= "111000";	-- Func (sra)
		wait for 100 ns;								-- 600 -700
		
		Instruction( 5 downto  0) <= "111001";	-- Func (srl)
		wait for 100 ns;								-- 700 - 800
		
		Instruction( 5 downto  0) <= "111010";	-- Func (sll)
		wait for 100 ns;								-- 800 - 900
		
		Instruction( 5 downto  0) <= "111100";	-- Func (rol)
		wait for 100 ns;								-- 900 - 1000
		
		Instruction( 5 downto  0) <= "111101";	-- Func (ror)
		wait for 100 ns;								-- 1000 - 1100

		Instruction(31 downto 26) <= "111000";	-- Opcode (li)
		Instruction( 5 downto  0) <= "000000";	-- don't care
		wait for 100 ns;								-- 1100 - 1200ns
		
		Instruction(31 downto 26) <= "111001";	-- Opcode (lui)
		wait for 100 ns;								-- 1200 - 1300ns
		
		Instruction(31 downto 26) <= "110000";	-- Opcode (addi)
		wait for 100 ns;							   -- 1300 - 1400							

		Instruction(31 downto 26) <= "110010";	-- Opcode (andi)
		wait for 100 ns;							   -- 1400 - 1500				

		Instruction(31 downto 26) <= "110011";	-- Opcode (ori)
		wait for 100 ns;							   -- 1500 - 1600							

		Instruction(31 downto 26) <= "111111";	-- Opcode (b)
		wait for 100 ns;							   -- 1600 - 1700					

		Instruction(31 downto 26) <= "010000";	-- Opcode (beq)
		wait for 100 ns;							   -- 1700 - 1800
		
		ALU_zero <= '1'; 						      -- Rs == Rt
		wait for 100 ns;							   -- 1800 - 1900

		Instruction(31 downto 26) <= "010001";	-- Opcode (bne)
		ALU_zero <= '0'; 						      -- Rs != Rt
		wait for 100 ns;						      -- 1900 - 2000
		
		ALU_zero <= '1'; 						      -- Rs == Rt
		wait for 100 ns;						      -- 2000 - 2100

		Instruction(31 downto 26) <= "000011";	-- Opcode (lb)
		ALU_zero <= '0'; 						      -- don't care
		wait for 100 ns;						      -- 2100 - 2200

		Instruction(31 downto 26) <= "000111";	-- Opcode (sb)
		wait for 100 ns; 							   -- 2200 - 2300
		
		Instruction(31 downto 26) <= "001111";	-- Opcode (lw)
		wait for 100 ns;							   -- 2300 - 2400
		
		Instruction(31 downto 26) <= "011111";	-- Opcode (sw)
		wait for 100 ns;							   -- 2400 - 2500
		wait;
   end process;
	
END;
