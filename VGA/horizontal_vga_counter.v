module horizontal_vga_counter (
    input clk_div,
    output reg [15:0] horizontal_count = 16'b0, 
    output reg enable_vertical_count = 1'b0
);

always @(posedge clk_div) begin
    if(horizontal_count < 799) begin
        horizontal_count <= horizontal_count + 1'b1;
        enable_vertical_count <= 1'b0;
	 end
    else begin
        horizontal_count <= 16'b0;	
        enable_vertical_count <= 1'b1;
    end
end
endmodule //horizontal_vga_counter