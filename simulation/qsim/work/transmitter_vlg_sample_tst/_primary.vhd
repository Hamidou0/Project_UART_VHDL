library verilog;
use verilog.vl_types.all;
entity transmitter_vlg_sample_tst is
    port(
        bclk            : in     vl_logic;
        GReset          : in     vl_logic;
        TDR             : in     vl_logic_vector(7 downto 0);
        TDRE            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end transmitter_vlg_sample_tst;
