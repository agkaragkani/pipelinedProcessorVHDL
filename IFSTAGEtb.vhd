--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:36:03 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/IFSTAGEtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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
 
ENTITY IFSTAGEtb IS
END IFSTAGEtb;
 
ARCHITECTURE behavior OF IFSTAGEtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);


   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          RST => RST,
          CLK => CLK,
          Instr => Instr
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
     
		-- hold RST state for 100 ns.
		
		RST <= '1';
      wait for CLK_period;	-- 0 - 100

      --wait for CLK_period*10;

      -- insert stimulus here 
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000000100
		-- Addr = 0000000001
		RST <= '0';
		PC_sel <= '0';
		PC_LdEn <= '1';
		PC_Immed <= x"0000_0001";		--1
      wait for CLK_period; -- 100 - 200
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000001000
		-- Addr = 0000000010
		wait for CLK_period; -- 200 - 300
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000001100
		-- Addr = 0000000011
		wait for CLK_period; -- 300 - 400
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000010000
		-- Addr = 0000000100
		wait for CLK_period; -- 400 - 500
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000010100
		-- Addr = 0000000101
		wait for CLK_period; -- 500 - 600

		-- PC = PC +4
		-- PCout = 00000000000000000000000000011000
		-- Addr = 0000000110
		wait for CLK_period; -- 600 - 700
		
		-- συνεχίζοντας μπορούμε να περάσουμε όλες τις εντολές
		-- αλλά θα χρησιμοποιήσουμε και τις υπόλοιπες μεταβλητές
		-- για να επιβεβαιώσουμε ότι δουλεύει.
		
		-- PC = PC +4 + PC_Immed 
		-- άρα αντί να πάμε στην επόμενη εντολή πάμε στην 3η επόμενη
		-- PCout = 00000000000000000000000000100100
		-- Addr = 0000001001
		PC_sel <= '1';
		PC_Immed <= x"0000_0008"; 
		wait for CLK_period;	-- 700 - 800
		
		-- PC = PC +4 
		-- περιμένουμε το Instr να παραμείνει ίδιο
		PC_sel <= '0';
		PC_LdEn <= '0';
		wait for CLK_period; --800 - 900
		
		-- PC = PC +4 + PC_Immed 
		-- άρα αντί να πάμε στην επόμενη εντολή πάμε στην 2η επόμενη (11η)
		-- PCout = 00000000000000000000000000101100
		-- Addr = 0000001011
		PC_sel <= '1';
		PC_LdEn <= '1';
		PC_Immed <= x"0000_0004";
		wait for CLK_period;	-- 900 - 1000
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000110000
		-- Addr = 0000001100
		PC_sel <= '0';
		wait for CLK_period; -- 1000 - 1100
		
		-- PC = PC +4
		-- PCout = 00000000000000000000000000110100
		-- Addr = 0000001101
		PC_sel <= '0';
		wait for CLK_period; -- 1100 - 1200
		
		-- PC = PC +4 + PC_Immed 
		-- περιμένουμε να μηδενιστει o PCout 
		-- άρα να περάσουμε πάλι στην 2η εντολή
		-- PCout = 00000000000000100000000000000100
		-- Addr = 0000000001
		PC_sel <= '1';
		PC_LdEn <= '1';
		PC_Immed <= x"0000_FFCC"; -- -52
		wait for CLK_period; --1200 - 1300
		
		-- πάμε στην επόμενη (3η)
		-- PCout = 00000000000000100000000000001000
		-- Addr = 0000000010
		PC_sel <= '0';
		wait for CLK_period; -- 1300 - 1400
		
		
		
		
		wait;
	end process;
END;
