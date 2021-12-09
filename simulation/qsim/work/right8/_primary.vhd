library verilog;
use verilog.vl_types.all;
entity right8 is
    port(
        shift           : in     vl_logic;
        a               : in     vl_logic_vector(7 downto 0);
        outp            : out    vl_logic_vector(7 downto 0);
        CLK             : in     vl_logic
    );
end right8;
