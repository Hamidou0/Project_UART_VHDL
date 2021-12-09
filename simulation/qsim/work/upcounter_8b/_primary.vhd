library verilog;
use verilog.vl_types.all;
entity upcounter_8b is
    port(
        Clock           : in     vl_logic;
        Resetn          : in     vl_logic;
        Enable          : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        Q               : out    vl_logic_vector(8 downto 0);
        o               : out    vl_logic
    );
end upcounter_8b;
