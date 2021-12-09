library verilog;
use verilog.vl_types.all;
entity left8_vlg_check_tst is
    port(
        outp            : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end left8_vlg_check_tst;
