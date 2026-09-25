--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:27:49 04/06/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/MEMSTAGEtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGEtb IS
END MEMSTAGEtb;
 
ARCHITECTURE behavior OF MEMSTAGEtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         CLK : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MEM_WrEn : IN  std_logic;
			sel : IN  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal CLK : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_WrEn : std_logic := '0';
	signal sel : std_logic := '0';

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          CLK => CLK,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MEM_WrEn => MEM_WrEn,
			 sel => sel
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
		
		wait for Clk_period;
		
		-- φορτώνω από τη διεύθνση 0 (11 downto 2) της μνήμης ό,τι έχω
		-- και το εμφανίζω στο MemdataOut αλλά δεν έχει τίποτα οπότε παιρνω 0
		sel<='1'; --lw
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000001";  									
		--MEM_DataIn<="11111111111111111111111111111111";			
      wait for Clk_period; --100-200
		
		--αποθηκεύω όλη τη λέξη στη διεύθυνση 0 της μνήμης
		--και πλέον θα έχω  #0 = MemDataIn = 11111111111111111111111111111111
		--το βλέπω και στο dout 
		--sel<='1'; --sw
		MEM_WrEn<='1';  
		--ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="11111111111111111111111111111111";
      wait for Clk_period; --200-300
		
		-- τώρα πάω να διαβάσω από αυτή τη θέση και όντως παίρνω 
		-- MemDataOut = #0 = MemDataIn = 11111111111111111111111111111111
		--sel<='1'; --lw
		MEM_WrEn<='0';  
		wait for Clk_period; --300-400
		
		--έχω non registered input άρα μπορώ να γράψω και σε μισό κύκλο
		-- άρα #0 = MemDataIn = 11111111111111111111111111000000
		MEM_WrEn<='1';  --sw
		ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="11111111111111111111111111000000";
      wait for Clk_period/2; --400-450
		
		--το δειχνω με το να φορτώσω. Εμφανίζεται κάτι
		--καινούριο, άρα έγραψα στη μνήμη
		MEM_WrEn<='0';  --lw
		wait for Clk_period/2; --450-500
		
		--αποθηκεύω όλη τη νέα λέξη στη διεύθυνση 0 της
		--μνήμης 
		sel<='1'; --sw
		MEM_WrEn<='1'; 
		ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="11111111111111111111111100000000";
      wait for Clk_period; --500-600
		
		--φορτώνω από τη μνήμη αυτο που υπήρχε στη θέση 0
		--άρα dataOut 
		sel<='1'; --lw
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="00000000111111111111111111111111";
      wait for Clk_period; --600-700
		
		-- φορτώνω  από διεύθυνση που δεν υπάρχει τίποτα
		-- γιατι η διεύθυνση είναι η 4 (9 down to 2)άρα 
		-- βλέπω ότι στο memdataout εμφανίζεται 0 όχι στο 
		-- rise του ρολογιού γιατι ειναι non registered
		sel<='0'; --lb
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="11111111111111111111111111111111";
      wait for Clk_period; --700-800
		
		-- αποθηκεύω το byte στη διεύθυνση 4 της μνήμης
		-- άρα αποθηκεύω το 11111111 στο #4 
		sel<='0'; --sb
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="11111111111111111111111111111111";
      wait for Clk_period; --800-900
		
		-- αποθηκεύω το byte στη διέθυνση 4 της μνήμης
		sel<='0'; --sb 
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="11111111111111111111111100000000";
      wait for Clk_period; --900-1000
		
		-- φορτώνω το byte από την προηγούμενη φορα που πλεον ειναι 0
		sel<='0'; --lb
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="00000000111111111111111111111110";
      wait for Clk_period; --1000-1100
		
		-- αποθηκεύω στη θέση 4
		-- εμφανίζω οχι στον παλμό του ρολογιού την προηγουμενη τιμη της εξοδου
		-- γιατι ειναι read first
		
		sel<='1'; --sw
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000010";
		MEM_DataIn<="11111111111111111100000000000111";
      wait for Clk_period; --1100-1200
		
		--αποθηκεύω την καινούρια τιμη στη διεύθυνση 4
		--φορτώνω την προηγούμενη
		sel<='1'; --sw
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000010";
		MEM_DataIn<="11111000000000000001111111111111";
      wait for Clk_period; --1200-1300
      -- insert stimulus here 
		
		-- φορτώνω το byte της προηγούμενης τιμης
		sel<='0'; --lb
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="00000000111111111111111111111110";
      wait for Clk_period;	--1300-1400

      wait;
   end process;

END;