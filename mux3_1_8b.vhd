LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux3_1_8b IS
	PORT (
		inp: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		a: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		c: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		
		o: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END mux3_1_8b;

ARCHITECTURE lgicmux3_1 OF mux3_1_8b IS
	
BEGIN

		o <= b when (inp = "01") else
			  c when (inp = "10") else 
			  a;
		
END lgicmux3_1;	