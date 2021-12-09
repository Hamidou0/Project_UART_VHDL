--------------------------------------------------------------------------------
-- Title         : Clock Divider Circuit
-- Project       : VHDL Example Programs
-------------------------------------------------------------------------------
-- File          : clk_div.vhd
-- Author        : Rami Abielmona  <rabielmo@site.uottawa.ca>
-- Created       : 2004/10/07
-- Last modified : 2007/09/26
-------------------------------------------------------------------------------
-- Description : This file creates a clock divider circuit using a behavioral approach.
--		 		 The code is extracted from "Rapid Prototyping Of Digital Systems" 
--				 by James Hamblen et Michael Furman.
-------------------------------------------------------------------------------
-- Modification history :
-- 2004.10.07 	R. Abielmona		Creation
-- 2007.09.26 	R. Abielmona		Modified copyright notice
-- 2021.12.06 Hamidou C & Gerald A Modication
library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY baude_gen IS
	PORT
	(	
		reset						: IN std_LOGIC;
		sel 						: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		clock_25Mhz				: IN	STD_LOGIC;
		clock_41				: OUT STD_LOGIC;
		clock_Hz				: OUT	STD_LOGIC);
END baude_gen;
ARCHITECTURE a OF baude_gen IS
	SIGNAL	count_1Mhz: STD_LOGIC_VECTOR(6 DOWNTO 0); 
	SIGNAL	count_clk : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL  clock_int: STD_LOGIC; 
BEGIN
	PROCESS 
	BEGIN
-- Divide by 41
		WAIT UNTIL clock_25Mhz'EVENT and clock_25Mhz = '1';
			IF count_1Mhz < 40 THEN
				count_1Mhz <= count_1Mhz + 1;
			ELSE
				count_1Mhz <= "0000000";
			END IF;
			IF count_1Mhz < 20 THEN
				clock_int <= '0';
			ELSE
				clock_int <= '1';
			END IF;	
	END PROCESS;	
--divide the previous clock signal using sel as a parameter	
	clock_41 <= clock_int;
	clock_divde_mux_combined: work.upcounter_8b PORT MAP(
											clock_int,reset,'1',sel,open, clock_Hz);
END a;