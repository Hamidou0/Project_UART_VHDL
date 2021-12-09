LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY transmitter IS
	PORT(
		GReset   : IN STD_LOGIC;
		TDRE		: IN STD_LOGIC;
		bclk		: IN  STD_LOGIC;
		TDR		: IN 	STD_LOGIC_VECTOR (7 downto 0);
		
		test_out_shif: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		test_out_clock8: OUT STD_LOGIC;
		test_out_start_shift: OUT STD_LOGIC;
		test_out_load: OUT STD_LOGIC;
		test_out_tsr: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		test_out_tsr_t: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		test_out_txd_y2: out std_LOGIC;
		states		: OUT STD_LOGIC_VECTOR(3 downto 0);
		
		reset_tdre: OUT STD_LOGIC;
		TxD		: OUT STD_LOGIC
	);
END transmitter;

ARCHITECTURE rtl OF transmitter IS
	SIGNAL load: STD_LOGIC;
	SIGNAL bclk8: STD_LOGIC;
	
	--SIGNAL trans_control: STD_LOGIC;
	SIGNAL TSR : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL TSR_t : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL TSR_shifted : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	
	SIGNAL Y3, Y2, Y1, Y0 : STD_LOGIC;
	SIGNAL yy3, yy2, yy1, yy0 : STD_LOGIC;
	SIGNAL st3, st2, st1, st0: STD_LOGIC;
	SIGNAL stabl: STD_LOGIC;
	
	SIGNAL shift_done: STD_LOGIC;
	SIGNAL TxD_mask: STD_LOGIC;
	SIGNAL TxD_out: STD_LOGIC;
	SIGNAL TxD_out_mux: STD_LOGIC;
	SIGNAL TxD_out_Y2: STD_LOGIC;
	
	SIGNAL reset: STD_LOGIC;
	SIGNAL shift_clock: STD_LOGIC;

BEGIN
	--unload <= load or trans_control;
	
		clock_divde_8_TR: work.upcounter_8b PORT MAP(
											bclk,'1','1',"010",open, bclk8);
	shift_counter: work.counter PORT MAP("1000",load,'1',bclk8,open,shift_done);
	tsr_shifting: work.right8 PORT MAP('1',TSR,TSR_t, shift_clock);
	
	shift_clock <= bclk when load = '0' else
						bclk8;
		
	tsr_mulitplexer: work.mux2_1_8b PORT MAP(load,TDR,TSR_shifted,TSR);
	tsr_shif_mux: work.mux2_1_8b PORT MAP(load,TDR,TSR_t,TSR_shifted);
	
	TxD_output: work.enARdFF_2 PORT MAP('1',TSR(0),load,bclk8,TxD_out_mux);
	TxD_output_Y2: work.enARdFF_2 PORT MAP('1',TSR(0),st1,bclk8,TxD_out_Y2);
	
	TxD_out <= TxD_out_Y2 when st2 = '1' else
				TxD_out_mux;
				
	--unload <= load or trans_control;
	reset<='0';

	
	st3 <= (yy3 and (not yy2) and (not yy1) and (not yy0)) and (not GReset);
	st2 <= (yy2 and (not yy3) and (not yy1) and (not yy0)) and (not GReset);
	st1 <= (yy1 and (not yy2) and (not yy3) and (not yy0)) and (not GReset);
	st0 <= (yy0 and (not yy2) and (not yy1) and (not yy3)) or (GReset);
	
	state_sig1: work.enARdFF_2 PORT MAP('1',Y3,stabl, bclk, yy3, open);
	state_sig2: work.enARdFF_2 PORT MAP('1',Y2,stabl, bclk, yy2, open);
	state_sig3: work.enARdFF_2 PORT MAP('1',Y1,stabl, bclk, yy1, open);
	state_sig4: work.enARdFF_2 PORT MAP('1',Y0,stabl, bclk, yy0, open);
	
	Y3 <= st2 and bclk8 and (not GReset);
	Y2 <= st1 and bclk8 and (not GReset);
	Y1 <= (st0 and TDRE) and bclk8 and (not GReset);
	Y0 <= (st0 and (not TDRE)) or (st3 and shift_done) or (GReset);
	stabl <= not (('0' xnor Y3 ) and
				 ('0' xnor Y2 ) and
				  ('0' xnor Y1 ) and
				    ('0' xnor Y0 ) );
					 
	TxD_mask<=st0;
	load <= st0 or st2 or st3;
	reset_tdre<=st0;
	TxD<= TxD_mask or TxD_out;
	
	
	---------------------
	-- test outputs to check signals
	---------------------
	test_out_clock8<=bclk8;
	test_out_shif<=TSR_shifted;
	test_out_start_shift<='1';
	test_out_tsr_t<=TSR_t;
	test_out_tsr<=TSR;
	test_out_load<=load;
	test_out_txd_y2<=txd_out_Y2;
	
	states(0) <= st0;
	states(3) <= st3;
	states(2) <= st2;
	states(1) <= st1;
	
	
	
END rtl;
