`timescale 1 ns/1 ps
module vertical_vga_counter(
    input clk_div,
    input enable_vertical_count,
    output reg [15:0] vertical_count 
);

always @(posedge clk_div) begin
    if(enable_vertical_count == 1'h1) begin
        if(vertical_count < 524)
            vertical_count <= vertical_count + 1;
        else begin
            vertical_count <= 0;
        end
    end
end
endmodule //horizontal_vga_counter