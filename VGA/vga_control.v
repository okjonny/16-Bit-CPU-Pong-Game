`timescale 1 ns/1 ps
module vga_control (
    input clk,
    output vertical_sync,
    output horizontal_sync,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
);

wire clk_div_25;
wire enable_vertical_count;
wire [15:0] vertical_count;
wire [15:0] horizontal_count;

clock_divider clock_25_d(.clk(clk), .div_clk(clk_div_25));
horizontal_vga_counter h_count(.clk_div(clk_div_25), .horizontal_count(horizontal_count), .enable_vertical_count(enable_vertical_count));
vertical_vga_counter v_count(.clk_div(clk_div_25), .enable_vertical_count(enable_vertical_count), .vertical_count(vertical_count));

//outputs
assign horizontal_sync = (horizontal_count < 96) ? 1'h1 : 1'h0;
assign vertical_sync = (vertical_count < 2) ? 1'h1 : 1'h0;

// RGB
assign r = (horizontal_count < 784 && horizontal_count > 143 && vertical_count < 515 && vertical_count > 34) ? 4'hF : 4'h0;
assign g = (horizontal_count < 784 && horizontal_count > 143 && vertical_count < 515 && vertical_count > 34) ? 4'hF : 4'h0;
assign b = (horizontal_count < 784 && horizontal_count > 143 && vertical_count < 515 && vertical_count > 34) ? 4'hF : 4'h0;


endmodule //vga_control