library verilog;
use verilog.vl_types.all;
entity receiver_vlg_sample_tst is
    port(
        bclk            : in     vl_logic;
        GReset          : in     vl_logic;
        RxD             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end receiver_vlg_sample_tst;
