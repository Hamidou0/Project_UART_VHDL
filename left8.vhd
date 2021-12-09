LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY left8 IS
	PORT (
		shift: IN STD_LOGIC;
		a: IN STD_LOGIC_VECTOR(7 DOWNTO 0);

		outp: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) ;

		CLK: IN STD_LOGIC);
END left8;

ARCHITECTURE logicLeft8 OF left8 IS
	SIGNAL o: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	
		sw: work.mux2_1_8b PORT MAP(shift, a, o, outp);
	
		o0: work.dFF_2 PORT MAP(a(6), CLK, o(7),open);
		o1: work.dFF_2 PORT MAP(a(5), CLK, o(6),open);
		o2: work.dFF_2 PORT MAP(a(4), CLK, o(5),open);
		o3: work.dFF_2 PORT MAP(a(3), CLK, o(4),open);
		o4: work.dFF_2 PORT MAP(a(2), CLK, o(3),open);
		o5: work.dFF_2 PORT MAP(a(1), CLK, o(2),open);
		o6: work.dFF_2 PORT MAP(a(0), CLK, o(1),open);
		o7: work.dFF_2 PORT MAP('0', CLK, o(0),open);
		
END logicLeft8;	


	