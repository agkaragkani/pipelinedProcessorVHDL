--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:49:10 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/DECSTAGEtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DECSTAGEtb IS
END DECSTAGEtb;
 
ARCHITECTURE behavior OF DECSTAGEtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         DecImmed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';

 	--Outputs
   signal DecImmed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RST => RST,
          CLK => CLK,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          DecImmed => DecImmed,
          RF_A => RF_A,
          RF_B => RF_B
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
		wait for CLK_period; -- 0 - 100
		
		-- Ard1 = 1
		-- Ard2 = 1
		-- Awr = 2
		-- Din = 65535
		-- δεν περνάει τίποτα γιατί ειναι διαφορετικοί
		-- Immed = 0 γιατί Instr(31-25) = 100000
		RST <= '0';
		RF_WrEn <= '1';
		RF_B_sel <= '0'; -- choosing Instr(15-11) as Ard2
	   Instr <= "10000000001000100000100000110000"; -- Instr(31-26)=100000 Instr(25-21)=1=Ard1 Instr(20-16)=2=Awr  Instr(15-11)=1=Ard2 Instr(10-6)= 0 (don't care) Instr(5-0)= 110000
		RF_WrData_sel <= '0'; -- choosing ALU_out as Din
		ALU_out <= x"0000_ffff";
		MEM_out <= x"ffff_0000";
		wait for CLK_period; -- 100 - 200
		
		-- Instr(25-21)= Instr(20-16)
		-- περιμενουμε Dout1=ALU_out
		-- Ard1 = 2
		-- Ard2 = 1
		-- Awr = 2
		-- Din = 65535
		Instr(25 downto 21)<="00010";
		Instr(31 downto 26)<="111000"; -- li για να δούμε sign extention στο Immed
		wait for CLK_period; -- 200 - 300

		-- WE = 0 άρα δεν περιμένουμε να περαστεί το Din στην έξοδο
		-- παρόλο που ο καταχωρητής εγγραφής είναι ο ίδιος με τους 
		-- καταχωρητές ανάγνωσης
		-- εμφανίζεται να αλλάζει το Dout2 γιατί με το RF B sel άλλαξε 
		-- η διεύθυνση του Ard2 και άρα στην εξοδο εμφανίζεται η προηγούμενη
		-- τιμη που αυτός είχε
		-- Ard1 = 2
		-- Ard2 = 2
		-- Awr = 2
		-- Din = -65535
		RF_B_sel <= '1'; -- choosing Instr(20-16) as Ard2
		RF_WrData_sel <= '1'; -- choosing MEM_out as Din
		RF_WrEn <= '0';
		wait for CLK_period; -- 300 - 400
		
		-- όπως πάνω όλοι οι καταχωρητές είναι ιδιοι
		-- και επιπλέον WE 1
		-- περιμένουμε άρα Dout1 = Dout2 = MEM out 
		RF_WrEn <= '1';
		Instr(31 downto 26)<="111001"; -- lui για να δούμε lower zero fill στο Immed

		wait for CLK_period; -- 400 - 500
		
		-- Ard1 = 7
		-- Ard2 = 15
		-- Awr = 3
		-- Din = -1
		-- δεν περνάει το Din στις εξόδους
		-- οι καταχωρητές διατηρούν την προηγούμενη τιμή τους
		-- που ήταν 0
		Instr(25 downto 21)<= "00111";
		Instr(20 downto 16)<= "00011";
		Instr(15 downto 11)<= "01111";
		Instr(31 downto 26)<="110010"; -- andi για να δούμε upper zero fill στο Immed

		RF_B_sel <= '0'; 
		RF_WrData_sel <= '0';
		ALU_out <= x"ffff_ffff";
		wait for CLK_period; -- 500 - 600
		
		-- Awr = Ard1 = 7 
		-- άρα περιμενουμε Dout1= RFA= ALUout
		Instr(20 downto 16)<= "00111";
		Instr(31 downto 26)<="111111"; -- b για να δούμε sign extention & 2sll στο Immed

		wait for CLK_period; -- 600 - 700
		
		--  Awr = Ard1 = Ard2 = 7 επειδη RF_B_sel=1
		-- άρα περιμενουμε Dout1= Dout2 = RFA= ALUout
		RF_B_sel <= '1'; 
		wait for CLK_period; -- 700 - 800
		
		-- προσπάθεια να γράψουμε στον R0
		-- Awr = Ard2 
		-- κανονικά θα έπρεπε Dout2 = ALU_out
		-- όμως επειδή ο καταχωρητής εγγραφης ειναι ο 0
		-- δεν μπορώ να γράψω και αρα Dout2 = 0
		Instr(20 downto 16) <= "00000";
		ALU_out <= x"f00f_f00f";
		wait for CLK_period; -- 800 - 900 
		
		-- 
		RST <= '1';
		wait for CLK_period; -- 900 - 1000
		

      wait;
   end process;

END;
