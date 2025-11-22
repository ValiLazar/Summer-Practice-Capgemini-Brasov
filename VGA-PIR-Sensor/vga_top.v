
module vga_top(
    input clk,
    input rst,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output Hsync,
    output Vsync,
    input Motion_detected
    );

wire clk_148_mhz;

design_1_wrapper clk_148Mhz
   (
    .clk_in1_0 (clk),
    .clk_out1_0 (clk_148_mhz),
    .reset_0(rst)
    );

    wire display_on;
    wire rst_n = ~rst;

    wire [11:0] h_count_wire;
    wire [10:0] v_count_wire;

    wire h_sync_n;
    wire v_sync_n;

    assign Hsync = h_sync_n;
    assign Vsync = v_sync_n;

    vga_1920X1080 vga_inst(
        .clk(clk_148_mhz),
        .rst_n(rst_n),
        .h_counter(h_count_wire),
        .v_counter(v_count_wire),
        .h_sync(h_sync_n),
        .v_sync(v_sync_n),
        .display_surface(display_on)
    );

    Pmod_PIR Pmod_PIR_inst(
        .clk_148_mhz(clk_148_mhz),
        .rst_n(rst_n),
        .Motion_detected(Motion_detected),
        .display_on(display_on),
        .vgaRed(vgaRed),
        .vgaGreen(vgaGreen),
        .vgaBlue(vgaBlue)
    );

    
endmodule