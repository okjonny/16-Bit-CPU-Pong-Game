`timescale 1 ns/1 ps
module vga_control_tb;

reg clk = 0;
wire vertical_sync;
wire horizontal_sync;
wire [3:0] r;
wire [3:0] g;
wire [3:0] b; 

vga_control UUT(.clk(clk), .vertical_sync(vertical_sync), .horizontal_sync(horizontal_sync), .r(r), .g(g), .b(b));

always #5 clk = ~clk;
endmodule //vga_control_tb