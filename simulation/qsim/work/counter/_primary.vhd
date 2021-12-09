library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        target          : in     vl_logic_vector(3 downto 0);
        i_resetBar      : in     vl_logic;
        i_load          : in     vl_logic;
        i_clock         : in     vl_logic;
        o_Value         : out    vl_logic_vector(3 downto 0);
        o               : out    vl_logic
    );
end counter;
