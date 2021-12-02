`timescale 1 ns / 1 ps
module horizontal_vga_counter (
    input clk_div,
    output reg [15:0] horizontal_count, 
    output reg enable_vertical_count
);

always @(posedge clk_div) begin
    if(horizontal_count < 799) begin
        horizontal_count <= horizontal_count + 1;
        enable_vertical_count <= 0;
	 end
    else begin
        horizontal_count <= 0;	
        enable_vertical_count <= 1;
    end
end
endmodule //horizontal_vga_counter