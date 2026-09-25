--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:40:49 04/06/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/DATAPATHtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATHtb IS
END DATAPATHtb;
 
ARCHITECTURE behavior OF DATAPATHtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
        -- PC_out : OUT  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrEn : IN  std_logic;
         Opcode : IN  std_logic_vector(5 downto 0);
         Instruction : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_zero : OUT  std_logic;
         MEM_WrEN : IN  std_logic_vector(0 downto 0);
			sel :  IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal Opcode : std_logic_vector(5 downto 0) := (others => '0');
   signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal MEM_WrEN : std_logic_vector(0 downto 0) := (others => '0');
	signal sel : std_logic := '0';

 	--Outputs
  -- signal PC_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          CLK => CLK,
          RST => RST,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
         -- PC_out => PC_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          RF_WrEn => RF_WrEn,
          Opcode => Opcode,
          Instruction => Instruction,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          MEM_WrEN => MEM_WrEN,
			 sel=>sel
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
		rst <= '1';
      wait for 100 ns;	

      --wait for CLK_period*10;

      -- insert stimulus here 
		--sel <= '1';	
		rst 	  <= '0';		 -- Setting Rst equal to 0
		PC_sel  <= '0'; 		 -- Setting PC_sel equal to 0
		wait for clk_period;
		---------------------------------------------------------------------------------------- 200ns
		PC_LdEn <= '1'; 		 -- Setting PC_LdEn equal to 1
		---------------------------------------------------------------------------------------- 200ns
		-- addi r5,r0,8 
		---------------------------------------------------------------------------------------- 200ns
		-- IFstage -------------
		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
		PC_LdEn       <= '1'; 	 -- Setting PC able to read the value comming for the mux
		-- DECstage ------------
		RF_WrEn    	  <= '1';	 -- Setting the RF able to write to registers			
		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.                    
		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(20-16)) on RF_B
		--ImmExt_s      <= "01";   -- Setting the ImmExt to perform sign extend
		-- EXstage -------------
		ALU_Bin_sel   <= '1';  	 -- Chooosing the Immed as the second input in ALU
		ALU_func 	  <= "0000"; -- Choosing the addition for the ALU func			 
		-- MEMstage ------------
		Mem_WrEn  	  <="0";	 -- Setting the write enable of ram off
		wait for clk_period;
		---------------------------------------------------------------------------------------- 300ns
		-- ori r3,r0,ABCD
		---------------------------------------------------------------------------------------- 300ns
		-- IFstage -------------
		PC_sel 		  <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
		PC_LdEn       <= '1';	 -- Setting PC able to read the value comming for the mux
		-- DECstage	------------	
		RF_WrEn       <= '1';	 -- Setting the RF able to write to registers	
		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register.
		RF_B_sel      <= '0';	 -- Choosing to read the register(instruction(15-11)) on RF_B
		--ImmExt_s      <= "00"; 	 -- Setting the ImmExt to perform zero fill
		-- EXstage -------------
		ALU_Bin_sel   <= '1';    -- Chooosing the Immed as the second input in ALU
		ALU_func      <= "0011"; -- Choosing the OR function for the ALU func		
		-- MEMstage ------------
		Mem_WrEn  <="0";		 -- Setting the write enable of ram off
		wait for clk_period;
		---------------------------------------------------------------------------------------- 400ns
		-- sw r3 4(r0)
		---------------------------------------------------------------------------------------- 400ns
		-- IFstage -------------
		PC_sel 		  <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
		PC_LdEn 	  <= '1'; 	 -- Setting PC able to read the value comming for the mux
		-- DECstage	------------	
		RF_WrEn 	  <= '0';	 -- Setting the RF not able to write to registers	
		RF_WrData_sel <= '1';    -- Choosing the MEM_out as the DataIN to register (Irrelevant)
		RF_B_sel  	  <= '1';    -- Choosing to read the register(instruction(20-16)) on RF_B
		--ImmExt_s	  <= "01";   -- Setting the ImmExt to perform sign extend
		-- EXstage -------------
		ALU_Bin_sel   <= '1';    -- Chooosing the Immed as the second input in ALU
		ALU_func  	  <= "0000"; -- Choosing the addition for the ALU func			
		-- MEMstage ------------
		Mem_WrEn  	  <= "1";    -- Setting the write enable of ram on
		wait for clk_period;
		---------------------------------------------------------------------------------------- 500ns
		-- lw r10,-4(r5)
		---------------------------------------------------------------------------------------- 500ns
		-- IFstage -------------
		PC_sel 		  <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
		PC_LdEn 	  <= '1'; 	 -- Setting PC able to read the value comming for the mux
		-- DECstage	------------	
		RF_WrEn 	  <= '1';	 -- Setting the RF able to write to registers
		RF_WrData_sel <= '1';    -- Choosing the MEM_out as the DataIN to register
		RF_B_sel      <= '0';    -- Choosing to read the register(instruction(15-11)) on RF_B
		--ImmExt_s      <= "01";   -- Setting the ImmExt to perform sign extend
		-- EXstage -------------
		ALU_Bin_sel   <= '1';    -- Chooosing the Immed as the second input in ALU
		ALU_func      <= "0000"; -- Choosing the addition for the ALU func	
		-- MEMstage ------------
		Mem_WrEn      <="0";     -- Setting the write enable of ram off
		wait for clk_period;
		---------------------------------------------------------------------------------------- 600ns
		-- lb r16 4(r0)
		---------------------------------------------------------------------------------------- 600ns
		-- IFstage -------------
		PC_sel        <= '0';    -- Setting PC value to increment by 4 in each clock cycle
		PC_LdEn 	  <= '1';    -- Setting PC able to read the value comming for the mux
		-- DECstage	------------	
		RF_WrEn 	  <= '1';	 -- Setting the RF able to write to registers
		RF_WrData_sel <= '1';    -- Choosing the MEM_out as the DataIN to register 
		RF_B_sel  	  <= '0';    -- Choosing to read the register(instruction(15-11)) on RF_B
		--ImmExt_s      <= "01";   -- Setting the ImmExt to perform sign extend
		-- EXstage -------------
		ALU_Bin_sel   <= '1';    -- Chooosing the Immed as the second input in ALU
		ALU_func  	  <= "0000"; -- Choosing the addition for the ALU func
		-- MEMstage ------------
		--ByteOp 		  <= '1';	 -- Choosing store byte operation from ram
		Mem_WrEn  	  <= "0";  	 -- Setting the write enable of ram off
		wait for clk_period*1;
		---------------------------------------------------------------------------------------- 700ns
		-- nand r4,r10,r16
		---------------------------------------------------------------------------------------- 700ns
		-- IFstage -------------
		PC_sel        <= '0'; 	 -- Setting PC value to increment by 4 in each clock cycle
		PC_LdEn 	  <= '1';	 -- Setting PC able to read the value comming for the mux	
		-- DECstage	------------	
		RF_WrEn       <= '1';    -- Setting the RF able to write to registers
		RF_WrData_sel <= '0';    -- Choosing the ALU_out as the DataIN to register 
		RF_B_sel      <= '0'; 	 -- Choosing to read the register(instruction(20-16)) on RF_B
		--ImmExt_s      <= "XX"; 	 -- Setting the ImmExt to perform nothing
		-- EXstage -------------
		ALU_Bin_sel   <= '0';  	 -- Chooosing the RF_B as the second input in ALU
		ALU_func      <= "0000"; -- Choosing the Nand operation for the ALU func
		-- MEMstage ------------
		Mem_WrEn      <= "0";    -- Setting the write enable of ram off
		wait for clk_period;
		---------------------------------------------------------------------------------------- 800ns
		RF_WrEn  <= '0';
		PC_LdEn <='0';

      wait;
   end process;

END;
