module Pmod_PIR (
             
    input clk_148_mhz,     
    input rst_n,             
    input Motion_detected, 
    input display_on,      
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
);
    // parameter SIGNAL_COUNT_TO = 300_000_000;
    // reg[32:0] signal_counter;
    // reg signal_ready;

    // always @(posedge clk_148_mhz or negedge rst_n) begin
    //     if(!rst_n) begin
    //         signal_counter <= 0;
    //         signal_ready <= 0;
    //     end
    //     else begin 
    //         if(Motion_detected == 1'b1) begin
    //             signal_counter <= 0;
    //             signal_ready <= 1;
    //         end
    //         else 
    //         if(signal_ready == 1) begin
    //             if (signal_counter == SIGNAL_COUNT_TO) begin
    //                 signal_ready <= 0;
    //                 signal_counter <= 0;
    //             end
    //             else begin
    //             signal_counter <= signal_counter + 1;
    //             end
    //         end
    //     end
    // end

    always @(posedge clk_148_mhz or negedge rst_n) begin
        if(!rst_n) begin
            vgaRed   <= 4'b0000;
            vgaGreen <= 4'b0000;
            vgaBlue  <= 4'b0000;
        end
        else if (display_on) begin
            if (Motion_detected == 1'b0) begin
                vgaRed   <= 4'b0000;
                vgaGreen <= 4'b1111;
                vgaBlue  <= 4'b0000;
            end else begin
                vgaRed   <= 4'b1111;
                vgaGreen <= 4'b0000;
                vgaBlue  <= 4'b0000;
            end 
        end
        else begin
            vgaRed   <= 4'b0000;
            vgaGreen <= 4'b0000;
            vgaBlue  <= 4'b0000;
        end
    end

endmodule