--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:02:59 04/05/2023
-- Design Name:   
-- Module Name:   C:/Users/georg/Desktop/COMP/COMP302PhaseA/RFtb.vhd
-- Project Name:  COMP302PhaseA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RFtb IS
END RFtb;
 
ARCHITECTURE behavior OF RFtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          CLK => CLK,
          RST => RST
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
		Rst<='1';
      wait for Clk_period;													-- 0 - 100ns

      -- wait for CLK_period*10;

      -- insert stimulus here 
		
		-- set RST off
		-- set WE on 
		Rst<='0';
		WrEn<='1';													
		
		-- Attempt to change the value of R0
		-- Dout1 is expected to remain 0
		-- Ard1 = R0
		-- Ard2 = R8
		-- Awr  = R0
	
		Ard1<="00000";
		Ard2<="01000";
		Awr<="00000";
		Din<=x"acdc_cdca";
		wait for Clk_period;												 	-- 100 - 200ns
			
		-- write enable deactivated
	   WrEn<='0';
		
		-- Ard1 = R0
		-- Ard2 = R5
		-- Awr  = R10
		-- expect nothing
		Ard2<="00101";
		Awr<="01010";
		Din<=x"abcd_abbb";
      wait for Clk_period ;												-- 200 - 300ns

		-- Ard1 = R1
		-- Ard2 = R0
		-- Awr  = R1	
		-- set Din to Dout1
		WrEn<='1';
		Ard2<="00000";
		Ard1<="00001";
		Awr<="00001";
		Din<=x"ffff_0000";
      wait for Clk_period;													-- 300 - 400ns
		
		
		-- Ard1 = R2
		-- Ard2 = R2
		-- Awr  = R2
		-- set Din to Dou1 and Dout2
		Ard1<="00010";
		Ard2<="00010";
		Awr<="00010";
		Din<=x"0f0f_00ff";
		wait for Clk_period;													-- 400 - 500ns
		
		-- Ard1 = R1
		-- Ard2 = R2
		-- Awr  = R17
		-- nothing, keep previous values
		-- Note: We changed Ard1 from R2 to R1
		-- so we keep the previous value from R1
		-- not from R2!!!
		Ard1<="00001";
		Ard2<="00010";
		Awr<="10001";
		Din<=x"0000_0002";
		wait for Clk_period;													-- 500 - 600ns
		
		-- Ard1 = R1
		-- Ard2 = R1
		-- Awr  = R1
		-- nothing, keep previous values
		-- because of setting of wren
		WrEn<='0';
		Ard1<="00001";
		Ard2<="00001";
		Awr<="00001";
		Din<=x"0000_0003";
		wait for Clk_period;													-- 600 - 700ns
		
		-- RST is activated
		-- Ard1 = R0
		-- Ard2 = R1
		-- Awr  = R1
		-- dout = 0
		Rst<='1';
		Ard1<="00000";
		Ard2<="00001";
		Awr<="00001";
		Din<=x"0000_0003";
		wait for Clk_period;													-- 700 - 800ns
		
		-- Ard1 = R15
		-- Ard2 = R15
		-- Awr  = R15
		-- set Din to Dout1 and Dout2
		Rst<='0';
		WrEn<='1';
		Ard1<="01111";
		Ard2<="01111";
		Awr<="01111";
		Din<=x"0000_ffff";
		wait for Clk_period;													-- 800 - 900ns

		-- Ard1 = R0
		-- Ard2 = R0
		-- Awr  = R0
		-- check again if we can write on R0
		Ard1<="00000";
		Ard2<="00000";
		Awr<="00000";
		Din<=x"0000_0001";													-- 900 - 1000ns
		wait for Clk_period;
      wait;
   end process;

END;