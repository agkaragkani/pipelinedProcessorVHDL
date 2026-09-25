----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:42 04/05/2023 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal output_signal: std_logic_vector(31 downto 0);
    signal cout_signal: std_logic_vector(32 downto 0);
    signal ovf_signal: std_logic;
    signal zero_signal: std_logic;
    
begin
    process(A,B,Op,output_signal,cout_signal,ovf_signal,zero_signal)

begin 

    case Op is
		  -- add
        when "0000" => 
            output_signal <= A+B;
		  -- sub
        when "0001" => 
            output_signal <= A-B;
		  -- and
        when "0010" => 
            output_signal <= A and B;
		  -- or
        when "0011" => 
            output_signal <= A or B;
		  -- not
        when "0100" => 
            output_signal <= not A;
		  -- sra
		  --Out= (int) A >> 1
		  --Αποτέλεσμα = {Α[31], Α[31], ... Α[1]} 
		  when "1000" => 
            output_signal(31) <= A(31);
            output_signal(30 downto 0) <= A(31 downto 1);
        -- srl
		  --Out= (unsigned int) A >> 1
		  --Αποτέλεσμα = {0, Α[31], ... Α[1]} 
		  when "1001" =>
            output_signal(31) <='0';
            output_signal(30 downto 0) <= A(31 downto 1);
        -- sll
		  -- Out= A << 1
		  -- Αποτέλεσμα = {Α[30], Α[29],... Α[0],0}
		  when "1010" =>
            output_signal(31 downto 1) <= A(30 downto 0);
            output_signal(0)<='0';
        -- left rotation
		  when "1100" =>
            output_signal(31 downto 1) <= A(30 downto 0);
            output_signal(0) <= A(31);
        -- right rotation
		  when "1101" =>
            output_signal(30 downto 0) <= A(31 downto 1);
            output_signal(31) <= A(0);
         when others =>
				output_signal <= x"0000_0000";
    end case; 
	 -- zero 
    if(output_signal = x"0000_0000") then
        zero_signal <= '1';
    else
        zero_signal <= '0';
    end if;
	 -- overflow
	 -- Signed integer overflow of the expression x+y+c (where c is 0 or 1) occurs 
	 -- if and only if x and y have the same sign and the result has sign opposite to that of the operands 
	 -- Signed integer overflow of the expression x-y-c (where c is again 0 or 1) occurs
	 -- if and only if x and y have opposite signs, and the sign of the result is opposite to that of x (or, equivalently, the same as that of y).
    if(((A(31) = '0') and (B(31)= '0') and (output_signal(31) = '1') )OR ((A(31) ='1') and (B(31)='1') and (output_signal(31)='0')))and Op = "0000"  then
       ovf_signal <= '1';
	 elsif (((A(31) = '0') and (B(31)= '1') and (output_signal(31) = '1') )OR ((A(31) ='1') and (B(31)='0') and (output_signal(31)='0')))and Op = "0001"  then
       ovf_signal <= '1';
    else
        ovf_signal <= '0';
    end if;    	
	 
	 -- carry out
	 if Op = "0000" then
		 cout_signal <= ('0' & A) + ('0' & B);
	 elsif 
		 Op = "0001" then
	 	 cout_signal <= ('0' & A) - ('0' & B);
	 else 
		 cout_signal(32) <=  '0';
	 end if;
	 Cout <= cout_signal(32);	
	
	 -- outputs 
    Output <= output_signal      ;
    Cout   <= cout_signal(32) ;  --MSB
    Ovf    <= ovf_signal      ;
    Zero   <= zero_signal     ;
    end process;
    
end Behavioral;
