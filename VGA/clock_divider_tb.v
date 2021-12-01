`timescale 1ns / 1 ps 
module clock_divider_tb;

reg clk = 0;
wire div_clk;

clock_divider UUT(
    .clk(clk),
    .div_clk(div_clk)
);

always #5 clk = ~clk;
endmodule //clock_divider_tb