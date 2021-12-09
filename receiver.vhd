LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY receiver IS
	PORT(
		GReset   : IN STD_LOGIC;
		RxD		: IN	STD_LOGIC;
		
		
		test_out_clock8: OUT STD_LOGIC;
		test_out_clock4: OUT STD_LOGIC;
		test_out_doneshi: OUT STD_LOGIC;
		
		
		bclk		: IN  STD_LOGIC;
		RDR		: OUT 	STD_LOGIC_VECTOR (7 downto 0);
		states		: OUT STD_LOGIC_VECTOR(3 downto 0);
		set_RDRF : OUT STD_LOGIC
	);
END receiver;

ARCHITECTURE rtl OF receiver IS
	SIGNAL bx4: STD_LOGIC;
	SIGNAL bclk8: STD_LOGIC;
	SIGNAL start_bx4: STD_LOGIC;

	SIGNAL Y3, Y2, Y1, Y0 : STD_LOGIC;
	SIGNAL yy3, yy2, yy1, yy0 : STD_LOGIC;
	SIGNAL st3, st2, st1, st0: STD_LOGIC;
	SIGNAL stabl: STD_LOGIC;
	
	SIGNAL unload: STD_LOGIC;
	
	SIGNAL shift_done: STD_LOGIC;
	SIGNAL start_shifting: STD_LOGIC;
	SIGNAL start_count: STD_LOGIC;
	
	SIGNAL reset: STD_LOGIC;
	
	SIGNAL RSR : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL RSR_t : STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN
	--unload <= load or trans_control;
	reset<='0';
	
	
	clock_divde_4: work.upcounter_8b PORT MAP(
											bclk,start_bx4,'1',"001",open, bx4);
	clock_divde_8: work.upcounter_8b PORT MAP(
											bclk,start_shifting,'1',"010",open, bclk8);
	sampling_counter: work.counter PORT MAP("1000",start_count,'1',bclk8,open,shift_done);
	rsr_shifting: work.left8 PORT MAP(start_count,RSR,RSR_t, bclk8);
	RxD_in: work.enARdFF_2 PORT MAP('1',RxD,start_count,bclk8,RSR_t(0));
	--------------------------------------------
	
	rsr_dff: work.enARdFF_2 PORT MAP('1',RSR_t(0), bclk8, RSR(0), open);
	rsr_dff2: work.enARdFF_2 PORT MAP('1',RSR_t(1), bclk8, RSR(1), open);
	rsr_dff0: work.enARdFF_2 PORT MAP('1',RSR_t(2), bclk8, RSR(2), open);
	rsr_dff3: work.enARdFF_2 PORT MAP('1',RSR_t(3), bclk8, RSR(3), open);
	rsr_dff4: work.enARdFF_2 PORT MAP('1',RSR_t(4), bclk8, RSR(4), open);
	rsr_dff5: work.enARdFF_2 PORT MAP('1',RSR_t(5), bclk8, RSR(5), open);
	rsr_dff6: work.enARdFF_2 PORT MAP('1',RSR_t(6), bclk8, RSR(6), open);
	rsr_dff7: work.enARdFF_2 PORT MAP('1',RSR_t(7), bclk8, RSR(7), open);

	--rdr_dff: work.enARdFF_2 PORT MAP('1',RSR, st3, RDR, open);
	
	RDR<=RSR;
	
	st3 <= yy3 and (not yy2) and (not yy1) and (not yy0);
	st2 <= yy2 and (not yy3) and (not yy1) and (not yy0);
	st1 <= yy1 and (not yy2) and (not yy3) and (not yy0);
	st0 <= yy0 and (not yy2) and (not yy1) and (not yy3);
	
	state_sig1: work.enARdFF_2 PORT MAP('1',Y3,stabl, bclk, yy3, open);
	state_sig2: work.enARdFF_2 PORT MAP('1',Y2,stabl, bclk, yy2, open);
	state_sig3: work.enARdFF_2 PORT MAP('1',Y1,stabl, bclk, yy1, open);
	state_sig4: work.enARdFF_2 PORT MAP('1',Y0,stabl, bclk, yy0, open);
	
	Y3 <= (st2 and shift_done) and bclk8 and (not GReset);
	Y2 <= ( (st2 and (not shift_done)) or (st1 and bx4) )and bclk8 and (not GReset);
	Y1 <= ( st0 and (not RxD) )and bclk8 and (not GReset);
	Y0 <= ( st3 or (st0 and RxD) or (st2 and RxD) ) or (GReset);
	stabl <= not (('0' xnor Y3 ) and
				 ('0' xnor Y2 ) and
				  ('0' xnor Y1 ) and
				    ('0' xnor Y0 ) );
					 
	states(0) <= st0;
	states(3) <= st3;
	states(2) <= st2;
	states(1) <= st1;
					 
	start_shifting<=st0 or st1 or st2 or st3;
	start_bx4<=st0 or st1;
	start_count<=st2;
	set_RDRF<=st3;
	
	
	
			test_out_clock8<=bclk8;
		test_out_clock4<=bx4;
		test_out_doneshi<=shift_done;
	
END rtl;
