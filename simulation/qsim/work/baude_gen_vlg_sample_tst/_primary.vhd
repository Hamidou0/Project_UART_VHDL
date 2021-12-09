library verilog;
use verilog.vl_types.all;
entity baude_gen_vlg_sample_tst is
    port(
        clock_25Mhz     : in     vl_logic;
        reset           : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end baude_gen_vlg_sample_tst;
