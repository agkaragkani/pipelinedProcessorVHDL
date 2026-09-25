----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:21:58 04/06/2023 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity PIPELINE_MEMSTAGE is
    Port ( CLK : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MEM_WrEn : in  STD_LOGIC;
			  sel: in STD_LOGIC; --;
			  Mem_ReadEn : in  STD_LOGIC
--			 RAM_we: in std_logic;
--			  RAM_a : in std_logic_vector(9 downto 0);
--			  RAM_d : in std_logic_vector(31 downto 0);
--			  RAM_spo : out std_logic_vector(31 downto 0)
			  );
end PIPELINE_MEMSTAGE;

architecture Behavioral of PIPELINE_MEMSTAGE is

SIGNAL MEM_DataInSignal : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL MEM_DataOutSignal : STD_LOGIC_VECTOR (31 downto 0);


component DistributedRam port (CLK : in std_logic;
										we : in std_logic;
										a : in std_logic_vector(9 downto 0);
										d : in std_logic_vector(31 downto 0);
										spo : out std_logic_vector(31 downto 0));
end component;

signal tmp_MEM_DataOut : STD_LOGIC_VECTOR (31 downto 0);
begin

MEMRAM: DistributedRam port map (CLK => CLK,
											we => MEM_WrEn,
											a => ALU_MEM_Addr(11 downto 2),
											d => MEM_DataInSignal,
											spo => MEM_DataOutSignal
											);
	
		
	-- store στη μνήμη κάνουμε μόνο όταν WE 1
	-- load όμως κάνουμε πάντα
	
	--	’ρα εχω τις εξής 4 περιπτώσεις:
	-- Αν έχω WE 1 & sel 1 (store word)
	-- MEM_DataInSignal <= MEM_DataIn WHEN '1' 
	-- MEM_DataOut <= MEM_DataOutSignal WHEN '1' 
	-- Αν έχω WE 1 & sel 0 (store byte)
	-- MEM_DataInSignal <=  "000000000000000000000000" & MEM_DataIn(7 DOWNTO 0)
	-- MEM_DataOut <=  "000000000000000000000000" & MEM_DataOutSignal(7 DOWNTO 0) WHEN '0'
	-- Αν έχω WE 0 & sel 1 (load word)
	-- (DINA = MEM_DataInSignal <= MEM_DataIn WHEN '1' ) απλά δεν αποθηκεύεται στην πραγματικότητα
	-- MEM_DataOut <= MEM_DataOutSignal WHEN '1' 
	-- Αν έχω WE 0 & sel 0 (load byte)
	-- MEM_DataOut <=  "000000000000000000000000" & MEM_DataOutSignal(7 DOWNTO 0) WHEN '0'
	
	
											
	WITH sel SELECT
	-- store				
	 --if sel 0, store byte
	 --else store word
	MEM_DataInSignal <=  "000000000000000000000000" & MEM_DataIn(7 DOWNTO 0) WHEN '0' ,
				       MEM_DataIn WHEN OTHERS;
	WITH sel SELECT

	--load
	-- if sel 0, load byte
	-- else load word
	MEM_DataOut <=  "000000000000000000000000" & MEM_DataOutSignal(7 DOWNTO 0) WHEN '0' ,
				       MEM_DataOutSignal WHEN OTHERS;



--
--process(sel, MEM_DataInSignal, MEM_DataOutSignal,tmp_MEM_DataOut )
--begin
--	case (sel) is
--							-- sw instruction
--		when '1' =>		if (Mem_WrEn = '1' and Mem_ReadEn = '0')		then	MEM_DataInSignal					<= MEM_DataIn	;				-- data to write in ram
--							-- lw instruction	
--							elsif (Mem_WrEn = '0' and Mem_ReadEn = '1')  then	tmp_MEM_DataOut 				<= MEM_DataOutSignal	;				-- data loades from ram
--		
--							end if;
--							-- sb instruction
--		when others =>	if (Mem_WrEn = '1' and Mem_ReadEn = '0')		then	MEM_DataInSignal <=  "000000000000000000000000" & MEM_DataIn(7 DOWNTO 0);
----		tmp_MM_WrData(31 downto 8) 	<= (others => '0');
----																tmp_MM_WrData(7 downto 0)		<= MEM_DataIn(7 downto 0);	-- data to write in ram
--							-- lb instruction	
--							elsif (Mem_WrEn = '0' and Mem_ReadEn = '1')  then	tmp_MEM_DataOut  <=  "000000000000000000000000" & MEM_DataOutSignal(7 DOWNTO 0);
--							--tmp_MEM_DataOut(31 downto 8) 	<= (others => '0');
--																						--tmp_MEM_DataOut(7 downto 0) 	<= MM_RdData(7 downto 0);	-- data loades from ram
--							end if;
--		end case;
--end process;

--MEM_DataOut	<=	tmp_MEM_DataOut ;
--MEM_DataINsignal	<= MEM_DataIn;
				
	
end Behavioral;

