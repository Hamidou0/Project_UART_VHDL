library verilog;
use verilog.vl_types.all;
entity transmitter is
    port(
        GReset          : in     vl_logic;
        TDRE            : in     vl_logic;
        bclk            : in     vl_logic;
        TDR             : in     vl_logic_vector(7 downto 0);
        test_out_shif   : out    vl_logic_vector(7 downto 0);
        test_out_clock8 : out    vl_logic;
        test_out_start_shift: out    vl_logic;
        test_out_load   : out    vl_logic;
        test_out_tsr    : out    vl_logic_vector(7 downto 0);
        test_out_tsr_t  : out    vl_logic_vector(7 downto 0);
        test_out_txd_y2 : out    vl_logic;
        states          : out    vl_logic_vector(3 downto 0);
        reset_tdre      : out    vl_logic;
        TxD             : out    vl_logic
    );
end transmitter;
