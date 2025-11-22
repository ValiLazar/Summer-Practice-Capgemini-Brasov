`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 12:49:58 PM
// Design Name: 
// Module Name: vga_640X400
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_top(
    input clk,
    input rst,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output Hsync,
    output Vsync,
    input btnU,
    input btnD,
    input btnL,
    input btnR
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
    
    vga_deplasare vga_deplasare_inst(
        .clk_148_mhz(clk_148_mhz),
        .rst_n(rst_n),
        .btnU(btnU),
        .btnD(btnD),
        .btnL(btnL),
        .btnR(btnR),
        .vgaBlue(vgaBlue),
        .vgaGreen(vgaGreen),
        .vgaRed(vgaRed),
        .h_count_wire(h_count_wire),
        .v_count_wire(v_count_wire),
        .display_on(display_on)

    );
    
    endmodule 

    // reg button_preview_up;
    // wire button_n_pressed_up;
    // reg pressed_UP;

    // assign button_n_pressed_up = btnU;

    // reg button_preview_down;
    // wire button_n_pressed_down;
    // reg pressed_DOWN;

    // assign button_n_pressed_down = btnD;

    // reg button_preview_right;
    // wire button_n_pressed_right;
    // reg pressed_RIGHT;

    // assign button_n_pressed_right = btnR;

    // reg button_preview_left;
    // wire button_n_pressed_left;
    // reg pressed_LEFT;

    // assign button_n_pressed_left = btnL;

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if (!rst_n) begin
    //         button_preview_up <= 0;
    //         button_preview_down <= 0;
    //         button_preview_left <= 0;
    //         button_preview_right <= 0;
    //     end
    //     else begin
    //         button_preview_up <= button_n_pressed_up;
    //         button_preview_down <= button_n_pressed_down;
    //         button_preview_left <= button_n_pressed_left;
    //         button_preview_right <= button_n_pressed_right; 
    //     end    
    // end
    
    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if(!rst_n) begin
    //         pressed_LEFT <= 0;
    //         pressed_RIGHT <= 0;
    //     end    
    //     else if(button_preview_left == 1 && button_n_pressed_left == 0) begin
    //         pressed_LEFT <= 1;
    //     end
    //     else if(button_preview_right == 1 && button_n_pressed_right == 0) begin
    //         pressed_RIGHT <= 1;
    //     end               
    //     else begin 
    //         pressed_LEFT <= 0;
    //         pressed_RIGHT <= 0;
    //     end    
    // end  

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if(!rst_n) begin
    //         pressed_UP <= 0;
    //         pressed_DOWN <= 0;
    //     end    
    //     else if(button_preview_up == 1 && button_n_pressed_up == 0) begin
    //         pressed_UP <= 1;
    //     end
    //     else if(button_preview_down == 1 && button_n_pressed_down == 0) begin
    //         pressed_DOWN <= 1;
    //     end               
    //     else begin 
    //         pressed_UP <= 0;
    //         pressed_DOWN <= 0;
    //     end    
    // end

    // reg [3:0] vgaRed_next;
    // reg [3:0] vgaBlue_next;
    // reg [3:0] vgaGreen_next;
    // reg [11:0] h_parameter;
    // reg [11:0] v_parameter; 


    // wire square;
    // assign square = (h_count_wire > h_parameter && h_count_wire < 200 + h_parameter) && 
    //                 (v_count_wire > v_parameter && v_count_wire < 200 + v_parameter);

    // parameter TRIANGLE_WIDTH = 200;
    // parameter TRIANGLE_HEIGHT = 200;

    // wire triangle;

    // wire signed [12:0] h_rel = h_count_wire - h_parameter; 
    // wire signed [11:0] v_rel = v_count_wire - v_parameter; 

    // wire rectangle_area = (h_count_wire >= h_parameter) && (h_count_wire < h_parameter + TRIANGLE_WIDTH) &&
    //                        (v_count_wire >= v_parameter) && (v_count_wire < v_parameter + TRIANGLE_HEIGHT);

    // wire signed [13:0] h_centered = h_rel - (TRIANGLE_WIDTH / 2);

    // wire signed [25:0] vertical_position = 2 * TRIANGLE_HEIGHT * h_centered;
    // wire signed [25:0] inclination = TRIANGLE_WIDTH * v_rel;

    // assign triangle = rectangle_area && (vertical_position <= inclination) && (vertical_position >= -inclination);

    // parameter CHECK_IN = 100;   

    // always @(*) begin
    //     vgaBlue_next = 4'b0000;
    //     vgaGreen_next = 4'b0000;
    //     vgaRed_next = 4'b0000;
    //     if (display_on) begin
    //         if(triangle) begin
    //             vgaRed_next = 4'b1111;
    //         end  
    //         if(obstacle) begin
    //             vgaBlue_next = 4'b1111;
    //         end         
    //     end  
    // end     

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if (!rst_n) begin
    //         h_parameter <= 760;
    //         v_parameter <= 440;
    //     end    
    //     else if(pressed_UP && v_parameter > CHECK_IN) begin
    //         v_parameter <= v_parameter - 100;
    //     end  
    //     else if(pressed_DOWN && (v_parameter + TRIANGLE_HEIGHT + CHECK_IN < 1080) ) begin
    //         v_parameter <= v_parameter + 100;
    //     end  
    //     else if(pressed_LEFT && h_parameter >= CHECK_IN) begin
    //         h_parameter <= h_parameter - 100;
    //     end        
    //     else if(pressed_RIGHT && (h_parameter + TRIANGLE_WIDTH + CHECK_IN < 1920)) begin
    //         h_parameter <= h_parameter + 100;
    //     end    
    // end 

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if (!rst_n) begin
    //         vgaBlue <= 4'b0000;
    //         vgaGreen <= 4'b0000;
    //         vgaRed <= 4'b0000;
    //     end    
    //     else begin
    //         vgaBlue <= vgaBlue_next;
    //         vgaGreen <= vgaGreen_next;
    //         vgaRed <= vgaRed_next;

    //     end    

    // end    
    
    // wire obstacle;
    // wire obstacle_top;
    // wire obstacle_botton;
    // reg [11:0] h_rectangle;
    // reg [10:0] v_rectangle;

    // assign obstacle_top = (h_count_wire > h_rectangle &&  h_count_wire < h_rectangle + 200) && (v_count_wire < v_rectangle && v_count_wire > 0);
    // assign obstacle_botton = (h_count_wire > h_rectangle &&  h_count_wire < h_rectangle + 200) && (v_count_wire < 1080 && v_count_wire > v_rectangle + 400);

    // assign obstacle = obstacle_botton || obstacle_top;


    // parameter COUNT_TO = 300000;
    // reg [21:0] counter;
    // reg enable;

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if(!rst_n) begin
    //         counter <= 0;
    //         enable <= 0;
    //     end    
    //     else if(counter == COUNT_TO) begin
    //         counter <= 0;
    //         enable <= 1;
    //     end
    //     else begin
    //         counter <= counter + 1;
    //         enable <= 0;
    //     end
    // end    

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if (!rst_n) begin
    //         h_rectangle <= 1720;
    //         v_rectangle <= 400;
    //     end
    //     else if (enable) begin
    //         h_rectangle <= h_rectangle - 1;
    //     end   
    // end
   