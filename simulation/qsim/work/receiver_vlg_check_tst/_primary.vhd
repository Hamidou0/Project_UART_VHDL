library verilog;
use verilog.vl_types.all;
entity receiver_vlg_check_tst is
    port(
        RDR             : in     vl_logic_vector(7 downto 0);
        set_RDRF        : in     vl_logic;
        states          : in     vl_logic_vector(3 downto 0);
        test_out_clock4 : in     vl_logic;
        test_out_clock8 : in     vl_logic;
        test_out_doneshi: in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end receiver_vlg_check_tst;
