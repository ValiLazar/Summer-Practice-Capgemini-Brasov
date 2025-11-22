`timescale 1ns / 1ps

module vga_deplasare(
    input clk_148_mhz,
    input rst_n,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaBlue,
    output reg [3:0] vgaGreen,
    input [11:0] h_count_wire,
    input [10:0] v_count_wire,
    input display_on
    );

    reg button_preview_up;
    wire button_n_pressed_up;
    reg pressed_UP;

    assign button_n_pressed_up = btnU;

    reg button_preview_down;
    wire button_n_pressed_down;
    reg pressed_DOWN;

    assign button_n_pressed_down = btnD;

    reg button_preview_right;
    wire button_n_pressed_right;
    reg pressed_RIGHT;

    assign button_n_pressed_right = btnR;

    reg button_preview_left;
    wire button_n_pressed_left;
    reg pressed_LEFT;

    assign button_n_pressed_left = btnL;

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if (!rst_n) begin
            button_preview_up <= 0;
            button_preview_down <= 0;
            button_preview_left <= 0;
            button_preview_right <= 0;
        end
        else begin
            button_preview_up <= button_n_pressed_up;
            button_preview_down <= button_n_pressed_down;
            button_preview_left <= button_n_pressed_left;
            button_preview_right <= button_n_pressed_right; 
        end     
    end

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if(!rst_n) begin
            pressed_LEFT <= 0;
            pressed_RIGHT <= 0;
        end     
        else if(button_preview_left == 1 && button_n_pressed_left == 0) begin
            pressed_LEFT <= 1;
        end
        else if(button_preview_right == 1 && button_n_pressed_right == 0) begin
            pressed_RIGHT <= 1;
        end             
        else begin
            pressed_LEFT <= 0;
            pressed_RIGHT <= 0;
        end     
    end   

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if(!rst_n) begin
            pressed_UP <= 0;
            pressed_DOWN <= 0;
        end     
        else if(button_preview_up == 1 && button_n_pressed_up == 0) begin
            pressed_UP <= 1;
        end
        else if(button_preview_down == 1 && button_n_pressed_down == 0) begin
            pressed_DOWN <= 1;
        end             
        else begin
            pressed_UP <= 0;
            pressed_DOWN <= 0;
        end     
    end

    reg [3:0] vgaRed_next;
    reg [3:0] vgaBlue_next;
    reg [3:0] vgaGreen_next;
    reg [11:0] h_parameter;
    reg [11:0] v_parameter; 

    wire square;
    assign square = (h_count_wire > h_parameter && h_count_wire < 200 + h_parameter) && 
                    (v_count_wire > v_parameter && v_count_wire < 200 + v_parameter);

    parameter TRIANGLE_WIDTH = 200;
    parameter TRIANGLE_HEIGHT = 200;

    wire triangle;

    wire signed [12:0] h_rel = h_count_wire - h_parameter; 
    wire signed [11:0] v_rel = v_count_wire - v_parameter; 

    wire rectangle_area = (h_count_wire >= h_parameter) && (h_count_wire < h_parameter + TRIANGLE_WIDTH) &&
                          (v_count_wire >= v_parameter) && (v_count_wire < v_parameter + TRIANGLE_HEIGHT);

    wire signed [13:0] h_centered = h_rel - (TRIANGLE_WIDTH / 2);

    wire signed [25:0] vertical_position = 2 * TRIANGLE_HEIGHT * h_centered;
    wire signed [25:0] inclination = TRIANGLE_WIDTH * v_rel;

    assign triangle = rectangle_area && (vertical_position <= inclination) && (vertical_position >= -inclination);

    parameter CHECK_IN = 100;   

    always @(*) begin
        vgaBlue_next = 4'b0000;
        vgaGreen_next = 4'b0000;
        vgaRed_next = 4'b0000;
        if (display_on) begin
            if(triangle) begin
                vgaRed_next = 4'b1111;
            end 
            if(obstacle) begin
                vgaBlue_next = 4'b1111;
            end     
        end   
    end     

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if (!rst_n || intersection) begin
            h_parameter <= 760;
            v_parameter <= 440;
        end     
        else if(pressed_UP && v_parameter > CHECK_IN) begin
            v_parameter <= v_parameter - 100;
        end 
        else if(pressed_DOWN && (v_parameter + TRIANGLE_HEIGHT + CHECK_IN < 1080) ) begin
            v_parameter <= v_parameter + 100;
        end 
        else if(pressed_LEFT && h_parameter >= CHECK_IN) begin
            h_parameter <= h_parameter - 100;
        end         
        else if(pressed_RIGHT && (h_parameter + TRIANGLE_WIDTH + CHECK_IN < 1920)) begin
            h_parameter <= h_parameter + 100;
        end     
    end 

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if (!rst_n) begin
            vgaBlue <= 4'b0000;
            vgaGreen <= 4'b0000;
            vgaRed <= 4'b0000;
        end     
        else begin
            vgaBlue <= vgaBlue_next;
            vgaGreen <= vgaGreen_next;
            vgaRed <= vgaRed_next;
        end     
    end     
    
    wire obstacle;
    wire obstacle_top;
    wire obstacle_botton;
    reg [11:0] h_rectangle;
    reg [10:0] v_rectangle;

    assign obstacle_top = (h_count_wire > h_rectangle &&  h_count_wire < h_rectangle + 200) && (v_count_wire < v_rectangle && v_count_wire > 0);
    assign obstacle_botton = (h_count_wire > h_rectangle &&  h_count_wire < h_rectangle + 200) && (v_count_wire < 1080 && v_count_wire > v_rectangle + 400);

    assign obstacle = obstacle_botton || obstacle_top;

    parameter COUNT_TO = 300000;
    reg [21:0] counter;
    reg enable;

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if(!rst_n) begin
            counter <= 0;
            enable <= 0;
        end     
        else if(counter == COUNT_TO) begin
            counter <= 0;
            enable <= 1;
        end
        else begin
            counter <= counter + 1;
            enable <= 0;
        end
    end     

    wire intersection;
    wire intersection_h;
    wire intersection_v;

    assign intersection_h = (h_parameter < h_rectangle + 200) && (h_rectangle < h_parameter + TRIANGLE_WIDTH);
    assign intersection_v = (v_parameter < v_rectangle) || (v_parameter + TRIANGLE_HEIGHT > v_rectangle + 400);

    assign intersection = intersection_h && intersection_v;

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if (!rst_n || intersection) begin
            h_rectangle <= 1720;
            v_rectangle <= 400;
        end
        else if (enable) begin
            h_rectangle <= h_rectangle - 1;
        end   
    end

endmodule
