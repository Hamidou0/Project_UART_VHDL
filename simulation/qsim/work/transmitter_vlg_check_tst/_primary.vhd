library verilog;
use verilog.vl_types.all;
entity transmitter_vlg_check_tst is
    port(
        reset_tdre      : in     vl_logic;
        states          : in     vl_logic_vector(3 downto 0);
        test_out_clock8 : in     vl_logic;
        test_out_load   : in     vl_logic;
        test_out_shif   : in     vl_logic_vector(7 downto 0);
        test_out_start_shift: in     vl_logic;
        test_out_tsr    : in     vl_logic_vector(7 downto 0);
        test_out_tsr_t  : in     vl_logic_vector(7 downto 0);
        test_out_txd_y2 : in     vl_logic;
        TxD             : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end transmitter_vlg_check_tst;
