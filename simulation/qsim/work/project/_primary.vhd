library verilog;
use verilog.vl_types.all;
entity project is
    port(
        sscs_raw        : in     vl_logic;
        msc             : in     vl_logic_vector(3 downto 0);
        ssc             : in     vl_logic_vector(3 downto 0);
        GClock          : in     vl_logic;
        GReset_raw      : in     vl_logic;
        mstl            : out    vl_logic_vector(2 downto 0);
        sstl            : out    vl_logic_vector(2 downto 0);
        main_t          : out    vl_logic;
        side_t          : out    vl_logic;
        ccc             : out    vl_logic;
        timer_reset     : out    vl_logic;
        c_reset         : out    vl_logic;
        stt2            : out    vl_logic_vector(3 downto 0);
        stt1            : out    vl_logic_vector(3 downto 0);
        stt             : out    vl_logic_vector(3 downto 0);
        states2         : out    vl_logic_vector(3 downto 0);
        states          : out    vl_logic_vector(3 downto 0)
    );
end project;
