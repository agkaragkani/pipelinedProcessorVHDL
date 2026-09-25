--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:14:19 04/07/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/IFDECALUtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFDECALU
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
 
ENTITY IFDECALUtb IS
END IFDECALUtb;
 
ARCHITECTURE behavior OF IFDECALUtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFDECALU
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         --PC_Immed : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         IFDECALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
			ALU_cout : out STD_LOGIC;
			ALU_ovf : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal IFDECALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
	signal ALU_cout : std_logic;
	signal ALU_ovf : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFDECALU PORT MAP (
          CLK => CLK,
          RST => RST,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          --PC_Immed => PC_Immed,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          MEM_out => MEM_out,
          RF_WrEn => RF_WrEn,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          IFDECALU_out => IFDECALU_out,
          ALU_zero => ALU_zero,
          ALU_cout => ALU_cout,
			 ALU_ovf => ALU_ovf

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
	stim_proc: process -- alu ouut den vazw, alu bin sel alu func 
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
		RF_B_sel <= '1'; 
		--ALU_out <= x"0000_ffff";
		ALU_Bin_sel <= '0';
		ALU_func <= "0000";
		MEM_out <= x"ffff_0000"; -- 100 - 200
		wait for CLK_period;
		
		-- PC (12)
		-- PCout (8)
		-- Addr 2 ara epomeni ston epomeno kyklo
      --ALU_Bin_sel <= '0';
		wait for CLK_period; -- 200 - 300
		
		-- PC = PC +4 (16)
		-- PCout = 00000000000000000000000000001100
		-- Addr = 0000000011
		--ALU_Bin_sel <= '0';
		ALU_func <= "0001";
		wait for CLK_period; -- 300 - 400
		
		-- PC = PC +4 (20)
		-- PCout = 00000000000000000000000000010000
		-- Addr = 0000000100
		--ALU_Bin_sel <= '0';
		ALU_func <= "0010";
		wait for CLK_period; -- 400 - 500
		
		-- PC = PC +4 (24)
		-- PCout = 00000000000000000000000000010100
		-- Addr = 0000000101
		--ALU_Bin_sel <= '1';
		ALU_func <= "0100";
		
		wait for CLK_period; -- 500 - 600
		
		-- PC = PC +4 (28)
		-- PCout = 00000000000000000000000000011000
		-- Addr = 0000000110
		--ALU_Bin_sel <= '0';
		ALU_func <= "0011";
		RF_B_sel <= '0'; 
		wait for CLK_period; -- 600 - 700

		-- PC = PC +4 (32)
		-- PCout = 00000000000000000000000000011100
		-- Addr = 0000000111
		--ALU_Bin_sel <= '0';
		ALU_func <= "1000";
		wait for CLK_period; -- 700 - 800
		
		-- συνεχίζοντας μπορούμε να περάσουμε όλες τις εντολές
		-- αλλά θα χρησιμοποιήσουμε και τις υπόλοιπες μεταβλητές
		-- για να επιβεβαιώσουμε ότι δουλεύει.
		
		-- PC = PC +4 + PC_Immed (36)
		-- εδω Immed 0 άρα στην επόμενη εντολή
		PC_sel <= '1';
		--ALU_Bin_sel <= '0';
		ALU_func <= "1001";
		--PC_Immed <= x"0000_0008"; 
		wait for CLK_period;	-- 800 - 900
		
		-- PC = PC +4 (40)
		-- περιμένουμε το Instr να παραμείνει ίδιο
		PC_sel <= '0';
		PC_LdEn <= '0';
		ALU_Bin_sel <= '0';
		ALU_func <= "1010";
		wait for CLK_period; --900 - 1000
      wait;
   end process;
	end;
