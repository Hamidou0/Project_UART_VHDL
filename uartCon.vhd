LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY uartCon IS
	PORT(
		GReset_c : IN std_logic;
		GClock	: IN std_LOGIC;
		sel_con		: IN std_LOGIC_VECTOR(2 downto 0);
		TxD_con	: OUT STD_logic;
		RxD_con	: IN STD_logic;
		
		TDR_con: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		
		MSTL	: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END uartCon;
ARCHITECTURE rtl OF uartCon IS
	signal intt_ON: std_logic;
	signal bclk_con  : std_logic;
	signal TDRE_con : std_logic;
	signal reset_trdre_con :std_LOGIC;
	signal set_rdrf_con: std_LOGIC;
	signal interr:std_LOGIC;
	signal GReset_con:std_LOGIC;
BEGIN
	Greset_con <= GReset_c or interr;
	transmitter: work.transmitter PORT MAP(
			GReset => Greset_con,
			TDRE => TDRE_con,
			bclk => bclk_con,
			TDR => TDR_con,
			reset_tdre => reset_trdre_con,
			TxD => TxD_con
		);
	receiver: work.receiver PORT MAP(
			GReset => GReset_con, RxD => Rxd_con,
			bclk => bclk_con,
			set_RDRF => set_RDRF_con
		);
	baud_rate: work.baude_gen PORT MAP(
			reset=>'1',sel=>sel_con,clock_25Mhz=>GClock,
			clock_41=>open,clock_Hz=>bclk_con
		);
	interrupt: work.interruptGen PORT MAP(
			RIE=> '1',TIE=> '1',OE=>'0',
			RDRF=> set_RDRF_con,
			TDRE=> reset_trdre_con
	);
END rtl;
