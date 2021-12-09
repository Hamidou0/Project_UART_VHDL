library verilog;
use verilog.vl_types.all;
entity project_vlg_check_tst is
    port(
        c_reset         : in     vl_logic;
        ccc             : in     vl_logic;
        main_t          : in     vl_logic;
        mstl            : in     vl_logic_vector(2 downto 0);
        side_t          : in     vl_logic;
        sstl            : in     vl_logic_vector(2 downto 0);
        states          : in     vl_logic_vector(3 downto 0);
        states2         : in     vl_logic_vector(3 downto 0);
        stt             : in     vl_logic_vector(3 downto 0);
        stt1            : in     vl_logic_vector(3 downto 0);
        stt2            : in     vl_logic_vector(3 downto 0);
        timer_reset     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end project_vlg_check_tst;
