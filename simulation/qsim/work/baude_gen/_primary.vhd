library verilog;
use verilog.vl_types.all;
entity baude_gen is
    port(
        reset           : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        clock_25Mhz     : in     vl_logic;
        clock_41        : out    vl_logic;
        clock_Hz        : out    vl_logic
    );
end baude_gen;
