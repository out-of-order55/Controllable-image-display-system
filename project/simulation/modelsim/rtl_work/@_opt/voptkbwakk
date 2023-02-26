library verilog;
use verilog.vl_types.all;
entity vga_ctrl is
    generic(
        H_SYNC          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0);
        H_BACK          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0);
        H_LEFT          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        H_VALID         : vl_logic_vector(0 to 11) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        H_RIGHT         : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        H_FRONT         : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0);
        H_TOTAL         : vl_logic_vector(0 to 11) := (Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0);
        V_SYNC          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1);
        V_BACK          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0);
        V_TOP           : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        V_VALID         : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        V_BOTTOM        : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        V_FRONT         : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1);
        V_TOTAL         : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0);
        RED             : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        vga_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        pix_data        : in     vl_logic_vector(15 downto 0);
        x               : in     vl_logic_vector(9 downto 0);
        y               : in     vl_logic_vector(9 downto 0);
        w               : in     vl_logic_vector(9 downto 0);
        h               : in     vl_logic_vector(9 downto 0);
        key_flag        : in     vl_logic;
        pix_data_req    : out    vl_logic;
        pix_x           : out    vl_logic_vector(11 downto 0);
        pix_y           : out    vl_logic_vector(11 downto 0);
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        rgb_valid       : out    vl_logic;
        pix_data1       : out    vl_logic_vector(15 downto 0);
        frame           : out    vl_logic;
        frame_begin     : out    vl_logic;
        frame_end       : out    vl_logic;
        rgb             : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of H_SYNC : constant is 1;
    attribute mti_svvh_generic_type of H_BACK : constant is 1;
    attribute mti_svvh_generic_type of H_LEFT : constant is 1;
    attribute mti_svvh_generic_type of H_VALID : constant is 1;
    attribute mti_svvh_generic_type of H_RIGHT : constant is 1;
    attribute mti_svvh_generic_type of H_FRONT : constant is 1;
    attribute mti_svvh_generic_type of H_TOTAL : constant is 1;
    attribute mti_svvh_generic_type of V_SYNC : constant is 1;
    attribute mti_svvh_generic_type of V_BACK : constant is 1;
    attribute mti_svvh_generic_type of V_TOP : constant is 1;
    attribute mti_svvh_generic_type of V_VALID : constant is 1;
    attribute mti_svvh_generic_type of V_BOTTOM : constant is 1;
    attribute mti_svvh_generic_type of V_FRONT : constant is 1;
    attribute mti_svvh_generic_type of V_TOTAL : constant is 1;
    attribute mti_svvh_generic_type of RED : constant is 1;
end vga_ctrl;
