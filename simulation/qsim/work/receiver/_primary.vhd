library verilog;
use verilog.vl_types.all;
entity receiver is
    port(
        GReset          : in     vl_logic;
        RxD             : in     vl_logic;
        test_out_clock8 : out    vl_logic;
        test_out_clock4 : out    vl_logic;
        test_out_doneshi: out    vl_logic;
        bclk            : in     vl_logic;
        RDR             : out    vl_logic_vector(7 downto 0);
        states          : out    vl_logic_vector(3 downto 0);
        set_RDRF        : out    vl_logic
    );
end receiver;
