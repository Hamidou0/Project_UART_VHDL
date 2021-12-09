LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY project IS
	PORT(
		sscs_raw	: IN	STD_LOGIC;
		
		msc, ssc			: IN STD_LOGIC_VECTOR(3 downto 0);
		
		GClock, GReset_raw			: IN	STD_LOGIC;
		
		mstl			: OUT	STD_LOGIC_VECTOR(2 downto 0);
		sstl			: OUT	STD_LOGIC_VECTOR(2 downto 0);
		main_t 	: OUT STD_LOGIC;
		side_t	:OUT STD_LOGIC;
		ccc	: OUT STD_LOGIC;
		timer_reset:OUT STD_LOGIC;
		c_reset:OUT STD_LOGIC;
		stt2		: OUT STD_LOGIC_VECTOR(3 downto 0);
		stt1		: OUT STD_LOGIC_VECTOR(3 downto 0);
		stt		: OUT STD_LOGIC_VECTOR(3 downto 0);
		states2		: OUT STD_LOGIC_VECTOR(3 downto 0);
		states		: OUT STD_LOGIC_VECTOR(3 downto 0));
END project;

ARCHITECTURE rtl OF project IS

	SIGNAL clk_d: STD_LOGIC;
	SIGNAL GReset: STD_LOGIC;
	SIGNAL sscs: STD_LOGIC;
	
	SIGNAL timer_z: STD_LOGIC;
	SIGNAL stabl: STD_LOGIC;
	
	SIGNAL Y3, Y2, Y1, Y0 : STD_LOGIC;
	SIGNAL yy3, yy2, yy1, yy0 : STD_LOGIC;
	
	SIGNAL st3, st2, st1, st0: STD_LOGIC;
	
	SIGNAL reset_c, reset_timer: STD_LOGIC;
	SIGNAL msc_t, ssc_t : STD_LOGIC;
	
	SIGNAL c : STD_LOGIC; -- YELLOW COUNTER
	
BEGIN


	clk_divider: work.clk_div PORT MAP(clock_25Mhz =>GClock, clock_1MHz=>clk_d);

	car_sensor_debouncer: work.debouncer PORT MAP(sscs_raw, GClock, sscs);
	reset_debouncer: work.debouncer PORT MAP(GReset_raw, GClock, GReset);
	
	main_timer: work.counter PORT MAP(msc,reset_timer,'1',GClock,stt2,msc_t);
	side_timer: work.counter PORT MAP(ssc,reset_timer,'1',GClock,stt1,ssc_t);
	yellow_timer: work.counter PORT MAP("1001",reset_c,'1',GClock,stt,c);
	
	st3 <= yy3 and (not yy2) and (not yy1) and (not yy0);
	st2 <= yy2 and (not yy3) and (not yy1) and (not yy0);
	st1 <= yy1 and (not yy2) and (not yy3) and (not yy0);
	st0 <= yy0 and (not yy2) and (not yy1) and (not yy3);
	
	state_sig1: work.enARdFF_2 PORT MAP('1',Y3,stabl, GClock, yy3, open);
	state_sig2: work.enARdFF_2 PORT MAP('1',Y2,stabl, GClock, yy2, open);
	state_sig3: work.enARdFF_2 PORT MAP('1',Y1,stabl, GClock, yy1, open);
	state_sig4: work.enARdFF_2 PORT MAP('1',Y0,stabl, GClock, yy0, open);
	
	Y3 <= ((st3 and ( (sscs and msc_t) or (not c) ) ) OR
			(st2 and ssc_t)) and (not GReset);
	Y2 <= ((st2 and ( (sscs and msc_t) or (not ssc_t) ) ) OR
			(st1 and c) )and (not GReset);
	Y1 <= ((st1 and ( (sscs and msc_t) or (not c) ) ) OR
			(st0 and (sscs and msc_t)) )and (not GReset);
	Y0 <= ((st0 and  (not sscs) ) OR
			(st3 and c) )or (GReset);
			
	reset_c <= (st1 or st3);
	reset_timer <= (st0 or st2);

	stabl <= not (('0' xnor Y3 ) and
				 ('0' xnor Y2 ) and
				  ('0' xnor Y1 ) and
				    ('0' xnor Y0 ) );
			
	mstl(2) <= st0;
	mstl(1) <= st1;
	mstl(0) <= st2 or st3;
	sstl(2) <= st2;
	sstl(1) <= st3;
	sstl(0) <= st0 or st1;
	
	states(0) <= Y0;
	states(3) <= Y3;
	states(2) <= Y2;
	states(1) <= Y1;
	states2(0) <= yy0;
	states2(3) <= yy3;
	states2(2) <= yy2;
	states2(1) <= yy1;
	
	main_t <= msc_t;
	side_t <= ssc_t;
	ccc <= c;
	timer_reset<=reset_timer;
	c_reset<=reset_c;
	

END rtl;
