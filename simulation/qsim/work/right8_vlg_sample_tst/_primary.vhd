library verilog;
use verilog.vl_types.all;
entity right8_vlg_sample_tst is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        CLK             : in     vl_logic;
        shift           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end right8_vlg_sample_tst;
