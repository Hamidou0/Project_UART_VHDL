LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY upcounter_8b IS
PORT (Clock, Resetn, Enable : IN STD_LOGIC ;
			sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			o : OUT STD_LOGIC) ;
END upcounter_8b;
ARCHITECTURE logic OF upcounter_8b IS
	SIGNAL output: STD_LOGIC;
	SIGNAL Count : std_logic_vector(8 DOWNTO 0);
	SIGNAL target: std_logic_vector(8 downto 0);
BEGIN
	PROCESS ( Clock , Resetn)
	BEGIN
		IF Resetn = '0' THEN
			Count <= "000000000";
			o <= '0';
		ELSIF output = '1' THEN
			Count <= "000000000";
			o <= '1';
		ELSIF rising_edge(Clock) THEN
			o <= '0';
			IF Enable = '1' THEN
				Count <= Count + 1 ;
			ELSE
				Count <= Count ;
			END IF ;
		END IF;
	END PROCESS;
	
target <= "000000010" when sel ="000" else
			 "000000100" when sel ="001" else
			 "000001000" when sel ="010" else
			 "000010000" when sel ="011" else
			 "000100000" when sel ="100" else
			 "001000000" when sel ="101" else
			 "010000000" when sel ="110" else
			 "100000000";
	
Q <= Count;
output	<= (Count(8) xnor target(8) ) AND
		(Count(7) xnor target(7) ) AND
		(Count(6) xnor target(6)) AND
		(Count(5) xnor target(5)) AND
		(Count(4) xnor target(4) ) AND
		(Count(3) xnor target(3)) AND
		(Count(2) xnor target(2)) AND
		(Count(1) xnor target(1) ) AND
		(Count(0) xnor target(0));
END logic;