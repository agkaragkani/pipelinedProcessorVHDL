--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:34:09 04/07/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/IFDECtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFDEC
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
 
ENTITY IFDECtb IS
END IFDECtb;
 
ARCHITECTURE behavior OF IFDECtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFDEC
    PORT(
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         --PC_Immed : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_OUT : IN  std_logic_vector(31 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0);
         RF_B_sel : IN  std_logic;
         RF_WrEn : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   --signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_OUT : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B_sel : std_logic := '0';
   signal RF_WrEn : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFDEC PORT MAP (
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          CLK => CLK,
          RST => RST,
          --PC_Immed => PC_Immed,
          RF_WrData_sel => RF_WrData_sel,
          ALU_out => ALU_out,
          MEM_OUT => MEM_OUT,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B,
          RF_B_sel => RF_B_sel,
          RF_WrEn => RF_WrEn
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
		-- O REG παίρνει τιμή εξόδου 1 κύκλο μετα από το PC
		-- αντίστοιχα η ROM βγάζει το Instr 1 κύκλο μετα από τον REG
		-- εξού και οι καθυστερήσεις
      -- hold reset state for 100 ns.
		-- addr 0 
		-- instr add
      RST <= '1';
      wait for CLK_period;	-- 0 - 100

      -- insert stimulus here 
		-- PC = PC +4 (8)
		-- PCout = 00000000000000000000000000000100
		-- Addr = 0000000001 (sub ston epomeno kyklo)
		RST <= '0';
		PC_sel <= '0';
		PC_LdEn <= '1';
		RF_WrEn <= '1';
		RF_B_sel <= '0'; -- choosing Instr(15-11) as Ard2
		ALU_out <= x"0000_ffff";
		MEM_out <= x"ffff_0000"; -- 100 - 200
		
		
		-- PC (12)
		-- PCout (8)
		-- Addr 2 ara epomeni ston epomeno kyklo
      wait for CLK_period; -- 200 - 300
		
		-- PC = PC +4 (16)
		-- PCout = 00000000000000000000000000001100
		-- Addr = 0000000011
		wait for CLK_period; -- 300 - 400
		
		-- PC = PC +4 (20)
		-- PCout = 00000000000000000000000000010000
		-- Addr = 0000000100
		wait for CLK_period; -- 400 - 500
		
		-- PC = PC +4 (24)
		-- PCout = 00000000000000000000000000010100
		-- Addr = 0000000101
		wait for CLK_period; -- 500 - 600
		
		-- PC = PC +4 (28)
		-- PCout = 00000000000000000000000000011000
		-- Addr = 0000000110
		wait for CLK_period; -- 600 - 700

		-- PC = PC +4 (32)
		-- PCout = 00000000000000000000000000011100
		-- Addr = 0000000111
		wait for CLK_period; -- 700 - 800
		
		-- συνεχίζοντας μπορούμε να περάσουμε όλες τις εντολές
		-- αλλά θα χρησιμοποιήσουμε και τις υπόλοιπες μεταβλητές
		-- για να επιβεβαιώσουμε ότι δουλεύει.
		
		-- PC = PC +4 + PC_Immed (36)
		-- εδω Immed 0 άρα στην επόμενη εντολή
		PC_sel <= '1';
		--PC_Immed <= x"0000_0008"; 
		wait for CLK_period;	-- 800 - 900
		
		-- PC = PC +4 (40)
		-- περιμένουμε το Instr να παραμείνει ίδιο
		PC_sel <= '0';
		PC_LdEn <= '0';
		wait for CLK_period; --900 - 1000

      wait;
   end process;

END;
