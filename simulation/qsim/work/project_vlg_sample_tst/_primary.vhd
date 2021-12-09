library verilog;
use verilog.vl_types.all;
entity project_vlg_sample_tst is
    port(
        GClock          : in     vl_logic;
        GReset_raw      : in     vl_logic;
        msc             : in     vl_logic_vector(3 downto 0);
        ssc             : in     vl_logic_vector(3 downto 0);
        sscs_raw        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end project_vlg_sample_tst;
