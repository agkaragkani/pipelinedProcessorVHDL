----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:46:24 04/06/2023 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL is
    Port ( RST : in  STD_LOGIC;
           Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : in  STD_LOGIC;
			  PC_sel : out  STD_LOGIC;
			  PC_LdEn : out  STD_LOGIC;
			  RF_WrEn : out  STD_LOGIC;
			  RF_WrData_sel : out  STD_LOGIC;
			  RF_B_sel : out  STD_LOGIC;
			  ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : out  STD_LOGIC;
           Opcode : out  STD_LOGIC_VECTOR (5 downto 0);
			  MEM_sel : out  STD_LOGIC
			  );
end CONTROL;

architecture Behavioral of CONTROL is

signal OpcodeSignal : STD_LOGIC_VECTOR (5 downto 0);

begin


	OpcodeSignal <= Instruction(31 downto 26);

	process(Instruction, OpcodeSignal, ALU_zero, Rst)
	
	
	begin 
	
		if Rst = '1' then
			PC_sel		<= '0';
			PC_LdEn		<= '0';
			RF_WrEn		<= '0';
			RF_WrData_sel <= '0';
			RF_B_sel		<= '0';
			Opcode		<= "000000";
			ALU_Bin_sel <= '0';
			ALU_func 	<= "0000";
			MEM_WrEn		<= '0';
			MEM_sel 			<= '0';
		else
			case OpcodeSignal is
				when "100000" => -- R Type
				-- opcode   rs	     rd	     rt	   shift 	func
				-- 6 bits	5 bits	5 bits	5 bits	5 bits  6 bits
				-- rd = rs rt
					ALU_func 		<= Instruction(3 downto 0); -- 
					ALU_Bin_sel 	<= '0'; -- SELECT RF_B as second input in ALU 
					RF_B_sel			<= '0'; -- SELECT Rt																				     
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					PC_sel 			<= '0'; -- PC +4
					MEM_sel 			<= '1'; -- don't care 
					
				when "111000" => -- I Type [ li ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed 
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					RF_B_sel			<= '1'; -- Select rd
					PC_sel 			<= '0'; -- PC +4
					MEM_sel 			<= '1'; -- don't care
					
				when "111001" => -- I Type [ lui ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed 
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					RF_B_sel			<= '1'; -- Select rd
					PC_sel 			<= '0'; -- PC+4
					MEM_sel 			<= '1'; -- don't care
					
				when "110000" => -- I Type [ addi ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed 
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					PC_sel 			<= '0'; -- PC +4 
					MEM_sel 			<= '1'; -- don't care
					RF_B_sel			<= '1'; -- Select rd
				
				when "110010" => -- I Type [ andi ]
					ALU_func 		<= "0010"; --(A AND B)
					ALU_Bin_sel 	<= '1'; -- SELECT Immed 
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					PC_sel 			<= '0'; -- PC +4
					MEM_sel 			<= '1'; -- don't care
					RF_B_sel			<= '1'; -- Select rd
				
				when "110011" => -- I Type [ ori ]
					ALU_func 		<= "0011"; -- OR
					ALU_Bin_sel 	<= '1'; -- SELECT Immed 
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					PC_sel 			<= '0'; -- PC +4
					MEM_sel 			<= '1'; -- don't care
					RF_B_sel			<= '1'; -- Select rd
					
				when "111111" => -- I Type [ b ]
					ALU_func 		<= "0000"; -- ADD
					ALU_Bin_sel 	<= '1'; -- SELECT Immed 
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_LdEn			<= '1'; -- PC Enabled
					PC_sel 			<= '1'; -- PC +4 + Immed
					MEM_sel 			<= '1'; -- don't care
					RF_B_sel			<= '1'; -- Select rd
					
				when "010000" => -- [ beq ]
					ALU_func 		<= "0001"; -- SUB
					RF_B_sel			<= '1'; -- SELECT rd
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '0'; -- SELECT RF B
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_sel 			<= ALU_zero;
					MEM_sel 			<= '1'; -- don't care
					
				when "010001" => -- [ bne ]
					ALU_func 		<= "0001"; -- SUB
					RF_B_sel			<= '1'; -- SELECT rd
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '0'; -- SELECT RF B
					RF_WrData_sel	<= '0'; -- SELECT ALU_out
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					PC_sel 			<= not ALU_zero;
					MEM_sel 			<= '1'; -- don't care
					
				when "000011" => -- [ lb ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '1'; -- SELECT MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					MEM_sel 			<= '0'; -- byte
					PC_sel 			<= '0'; -- PC +4
					RF_B_sel			<= '1'; -- select rd
					
				when "000111" => -- [ sb ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '0'; -- SELECT ALU
					RF_B_sel			<= '1'; -- B out goes into MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '1'; -- Writing to MEM
					MEM_sel 			<= '0'; -- byte
					PC_sel 			<= '0'; -- PC +4
					
					
				when "001111" => -- [ lw ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '1'; -- SELECT MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '1'; -- RegisterFile Enabled
					MEM_WrEn			<= '0'; -- Not Storing Data
					MEM_sel 			<= '1'; -- word
					PC_sel 			<= '0'; -- PC +4 
					RF_B_sel			<= '1'; -- Select rd
					
				
				when "011111" => -- [ sw ]
					ALU_func 		<= "0000"; -- ADD
					RF_WrData_sel  <= '0'; -- SELECT ALU
					RF_B_sel			<= '1'; -- B out goes into MEM
					PC_LdEn			<= '1'; -- PC Enabled
					ALU_Bin_sel 	<= '1'; -- SELECT Immed
					RF_WrEn			<= '0'; -- RegisterFile Disabled
					MEM_WrEn			<= '1'; -- Writing to MEM
					MEM_sel 			<= '1'; -- word
					PC_sel 			<= '0'; -- PC +4
					RF_B_sel			<= '1'; -- select rd
					
				
				when others =>
					ALU_Bin_sel <= '0';
					ALU_func 	<= "0000";
					RF_WrEn		<= '0';
					MEM_WrEn		<= '0';
					PC_LdEn		<= '0';
					RF_B_sel		<= '0';
					PC_sel		<= '0';
					MEM_sel 			<= '1';
					PC_sel 			<= '0';
			end case;
		end if;
		
		
		Opcode<= OpcodeSignal;

	end process;

end Behavioral;
