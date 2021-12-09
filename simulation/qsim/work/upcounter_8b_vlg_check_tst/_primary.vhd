library verilog;
use verilog.vl_types.all;
entity upcounter_8b_vlg_check_tst is
    port(
        o               : in     vl_logic;
        Q               : in     vl_logic_vector(8 downto 0);
        sampler_rx      : in     vl_logic
    );
end upcounter_8b_vlg_check_tst;
