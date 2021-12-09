LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY interruptGen IS
	PORT(
		
		RIE : IN std_logic;
		TIE : IN std_logic;
		
		RDRF : IN std_logic;
		OE : IN std_logic;
		TDRE : IN std_logic;
		
		interrupt: OUT std_logic
	);
END interruptGen;

ARCHITECTURE rtl OF interruptGen IS

	signal intt_ON: std_logic;
BEGIN

	interrupt <= '1' when( (RIE = '1') and ((RDRF = '1') or (OE = '1')) )else
					 '1' when( (TIE = '1') and ((TDRE = '1') or (OE = '1')) )else
		'0';
	
END rtl;
