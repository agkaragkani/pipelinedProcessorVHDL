--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:50:43 04/15/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/FinalDatapathTb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FinalDatapath
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
 
ENTITY FinalDatapathTb IS
END FinalDatapathTb;
 
ARCHITECTURE behavior OF FinalDatapathTb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FinalDatapath
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN  std_logic;
         MEM_sel : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
         ALU_cout : OUT  std_logic;
         ALU_ovf : OUT  std_logic;
         MEM_Data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal MEM_WrEn : std_logic := '0';
   signal MEM_sel : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   signal ALU_cout : std_logic;
   signal ALU_ovf : std_logic;
   signal MEM_Data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FinalDatapath PORT MAP (
          CLK => CLK,
          RST => RST,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          MEM_WrEn => MEM_WrEn,
          MEM_sel => MEM_sel,
          Instr => Instr,
          ALU_zero => ALU_zero,
          ALU_cout => ALU_cout,
          ALU_ovf => ALU_ovf,
          MEM_Data_out => MEM_Data_out
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
      wait for CLK_period;	-- 0 - 100ns
		
      -- insert stimulus here
		RST <= '0';
		
		-- li r1,6
		-- li r2,6
		-- wait for 2 periods
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	 -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled			
		RF_WrData_sel <= '0';    -- SELECT ALU_out                    
		RF_B_sel      <= '1';	 -- Select rd register(instruction(20-16)) on RF_B
		ALU_Bin_sel   <= '1';  	 -- SELECT IMMED as second input in ALU 
		ALU_func 	  <= "0000"; -- add			 
		Mem_WrEn  	  <='0';	    -- not storing data
		Mem_sel  	  <='1';     -- don't care
		wait for clk_period*2;   -- 100 - 300ns
		
		-- add r1,r3,r2  
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled					
		RF_WrData_sel <= '0';    -- SELECT ALU_out                         
		RF_B_sel      <= '0';	  -- Select rt register(instruction(15-11)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "0000"; -- add			 
		Mem_WrEn  	  <='0';	 	-- not storing data
		Mem_sel  	  <='1';		-- don't care
		wait for clk_period;		 -- 300 - 400ns
		
		-- bne r1,r2,0 
		PC_sel        <= not ALU_zero;
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '0';	 -- RegisterFile Disabled			
		RF_WrData_sel <= '0';   -- SELECT ALU_out                           
		RF_B_sel      <= '1';	  -- Select rd register(instruction(20-16)) on RF_B
		ALU_Bin_sel   <= '0';  	-- SELECT RF_B as second input in ALU
		ALU_func 	  <= "0001"; -- sub		 
		Mem_WrEn  	  <='0';	    -- not storing data
		Mem_sel  	  <='1';		-- don't care
		wait for clk_period;		 -- 400 - 500ns
		
		-- beq r1,r2,0  
		PC_sel        <= ALU_zero;
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '0';	 -- RegisterFile Disabled			
		RF_WrData_sel <= '0';    -- SELECT ALU_out                               
		RF_B_sel      <= '1';	  -- Select rd register(instruction(20-16)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "0001"; -- sub			 
		Mem_WrEn  	  <='0';	    -- not storing data
		Mem_sel  	  <='1';			-- don't care
		wait for clk_period;     --500 - 600ns
		
		-- lui r8,4
		--lui r10,16 
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	-- RegisterFile Enabled				
		RF_WrData_sel <= '0';    -- SELECT ALU_out                        
		RF_B_sel      <= '1';	  -- Select rd register(instruction(20-16)) on RF_B
		ALU_Bin_sel   <= '1';  	 -- SELECT IMMED as second input in ALU
		ALU_func 	  <= "0000"; -- add		 
		Mem_WrEn  	  <='0';	    -- not storing data
		Mem_sel  	  <='1';		-- don't care
		wait for clk_period*2;   -- 600 - 800ns
		
		-- or r8,r5,r10  
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled			
		RF_WrData_sel <= '0';    -- SELECT ALU_out                            
		RF_B_sel      <= '0';	  -- Select rt register(instruction(15-11)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "0011"; -- or	 
		Mem_WrEn  	  <='0';	   -- not storing data
		Mem_sel  	  <='1';			-- don't care
		wait for clk_period;     -- 800 - 900ns
		
		-- rol r5,r6,1 
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled			
		RF_WrData_sel <= '0';    -- SELECT ALU_out                               
		RF_B_sel      <= '0';	 -- Select rt register(instruction(15-11)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "1100"; -- rol	 
		Mem_WrEn  	  <='0';	    -- not storing data
		Mem_sel  	  <='1';			-- don't care
		wait for clk_period;		 -- 900 - 1000ns
		
		-- ror r6,r5,1 
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled					
		RF_WrData_sel <= '0';    -- SELECT ALU_out                             
		RF_B_sel      <= '0';	 -- Select rt register(instruction(15-11)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "1101"; -- ror 
		Mem_WrEn  	  <='0';	    -- not storing data
		Mem_sel  	  <='1';		-- don't care
		wait for clk_period;		 -- 1000 - 1100ns
		
		-- sw r5,4(r10) 
		PC_sel        <= '0';	 -- PC + 4	
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '0';	 -- RegisterFile Disabled					
		RF_WrData_sel <= '0';    -- SELECT ALU_out                            
		RF_B_sel      <= '1';	 -- Select rd register(instruction(20-16)) on RF_B
		ALU_Bin_sel   <= '1';  	 -- SELECT IMMED as second input in ALU
		ALU_func 	  <= "0000"; -- add			 
		Mem_WrEn  	  <='1';	    -- storing data
		Mem_sel  	  <='1';		-- word
		wait for clk_period;		 -- 1100 - 1200ns
		
		-- addi r1,r2,3 
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled						
		RF_WrData_sel <= '0';    -- SELECT ALU_out                    
		RF_B_sel      <= '1';	 -- Select rd register(instruction(20-16)) on RF_B
		ALU_Bin_sel   <= '1';  	 --- SELECT immed as second input in ALU
		ALU_func 	  <= "0000"; -- add		 
		Mem_WrEn  	  <='0';	-- not storing data
		Mem_sel  	  <='1';		-- don't care
		wait for clk_period; 	-- 1200 - 1300
		
		
		-- sub r2,r1,r3
		PC_sel        <= '0'; 	-- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled						
		RF_WrData_sel <= '0';    -- SELECT ALU_out                         
		RF_B_sel      <= '0';	 -- Select rt register(instruction(15-11)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "0001"; -- sub		 
		Mem_WrEn  	  <='0';	 -- not storing data
		Mem_sel  	  <='1';			-- don't care
		wait for clk_period;		-- 1300 - 1400
		
		-- sll r4,r2,r1 
		PC_sel        <= '0'; 	 -- PC + 4
		PC_LdEn       <= '1'; 	  -- PC Enabled
		RF_WrEn    	  <= '1';	 -- RegisterFile Enabled				
		RF_WrData_sel <= '0';    -- SELECT ALU_out              
		RF_B_sel      <= '0';	 -- Select rt register(instruction(15-11)) on RF_B
		ALU_Bin_sel   <= '0';  	 -- SELECT RF_B as second input in ALU
		ALU_func 	  <= "1010"; --sll			 
		Mem_WrEn  	  <='0';	 -- not storing data
		Mem_sel  	  <='1';			-- don't care
		wait for clk_period;		-- 1400 - 1500
		
		
		-- in case we need to change the coe file, following code is for the other cases
--		-- SUB INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 
--		PC_LdEn       <= '1'; 	
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 			
--		RF_WrData_sel <= '0';                      
--		RF_B_sel      <= '0';	
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 
--		ALU_func 	  <= "0001";  
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- AND INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "0010"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- NOT INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "0100"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--
--		-- OR INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "0011"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- SRA INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "1000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- SRL INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "1001"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- SLL INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "1010"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- ROL INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "1100"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- ROR INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(15-11)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU_out as the second input in ALU
--		ALU_func 	  <= "1101"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- LI INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the IMMED as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- LUI INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the IMMED as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- ADDI INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the IMMED as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- ANDI INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the IMMED as the second input in ALU
--		ALU_func 	  <= "0010"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- ORI INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the IMMED as the second input in ALU
--		ALU_func 	  <= "0011"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- B INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '0';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the IMMED as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- BEQ INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= ALU_zero;
--		--PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '0';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU OUT as the second input in ALU
--		ALU_func 	  <= "0001"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- BNE INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= not ALU_zero;
--		--PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '0';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '0';  	 -- Chooosing the ALU OUT as the second input in ALU
--		ALU_func 	  <= "0001"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--
--		-- LB INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0';
--		--PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '1';    -- Choosing the IMMED as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the ALU OUT as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='0';
--		wait for clk_period;
--		
--		-- SB INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0';
--		--PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '0';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the  as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the ALU OUT as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='1';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='0';
--		wait for clk_period;
--		
--		-- LW INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0';
--		--PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '1';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '1';    -- Choosing the  as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the ALU OUT as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='0';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
--		-- SW INSTRUCTION 
--		-- IFstage -------------
--		PC_sel        <= '0';
--		--PC_sel        <= '1'; 	 -- Setting PC value to increment by 4 in each clock cycle
--		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
--		-- DECstage ------------
--		RF_WrEn    	  <= '0';	 -- Setting the RF unable to write to registers			
--		RF_WrData_sel <= '0';    -- Choosing the  as the DataIN to register.                    
--		RF_B_sel      <= '1';	 -- Choosing to read the register(instruction(20-16)) on RF_B
--		-- EXstage -------------
--		ALU_Bin_sel   <= '1';  	 -- Chooosing the ALU OUT as the second input in ALU
--		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
--		-- MEMstage ------------
--		Mem_WrEn  	  <='1';	 -- Setting the write enable of ram off
--		Mem_sel  	  <='1';
--		wait for clk_period;
--		
      wait;
   end process;

END;
