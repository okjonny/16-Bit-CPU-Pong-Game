module vga_control (
	input	clk, rst,
	output hsync, vsync,
	output reg vga_blank_n, vga_clk,
	output reg [15:0] hcount, vcount,
	
   input [3:0] r_in;
   input [3:0] g_in;
   input [3:0] b_in;
	
	output [3:0] r_out;
   output [3:0] g_out;
   output [3:0] b_out;
);

reg count;

// parameters for a VGA 640 x 480 (60Hz) display
// dropping our 50MHz clock to a 25MHz pixel clock

parameter H_SYNC        = 16'd95;  // 3.8us  -- 25M * 3.8u  = 95
parameter H_BACK_PORCH  = 16'd48;  // 1.9us  -- 25M * 1.9u  = 47.5
parameter H_DISPLAY_INT = 16'd635; // 25.4us -- 25M * 25.4u = 635
parameter H_FRONT_PORCH = 16'd15;  // 0.6us  -- 25M * 0.6u  = 15
parameter H_TOTAL       = 16'd793; // total width -- 95 + 48 + 635 + 15 = 793

parameter V_SYNC        = 16'd2;   // 2 lines
parameter V_BACK_PORCH  = 16'd33;  // 33 lines
parameter V_DISPLAY_INT = 16'd480; // 480 lines
parameter V_FRONT_PORCH = 16'd10;  // 10 lines
parameter V_TOTAL       = 16'd525; // total width -- 2 + 33 + 480 + 10 = 525

assign hsync = ~((hcount >= H_BACK_PORCH) & (hcount < H_BACK_PORCH + H_SYNC));
assign vsync = ~((vcount >= V_DISPLAY_INT + V_FRONT_PORCH) & (vcount < V_DISPLAY_INT + V_FRONT_PORCH + V_SYNC));

always @(posedge clk) begin
	
	if (rst) begin
		vcount  <= 16'd0;
		hcount  <= 16'd0;
		count   <= 1'b0;
		vga_clk <= 1'b0;
	end
	
	else if (count) begin
		hcount <= hcount + 1'b1;
		
		// clear if reaches end
		if (hcount == H_TOTAL) begin
			hcount <= 10'd0;
			vcount <= vcount + 1'b1;
			
			if (vcount == V_TOTAL)
				vcount <= 10'd0;
		end
	end
	
	vga_clk <= ~vga_clk; // generates 25MHz vga_clk
	count   <= ~count;
end

always @(hcount,vcount) begin
	
	// bright
	if ((hcount >= H_BACK_PORCH + H_SYNC + H_FRONT_PORCH) &&
		 (hcount < H_TOTAL - H_FRONT_PORCH) && (vcount < V_DISPLAY_INT))
		 vga_blank_n = 1'b1;
	 else 
		vga_blank_n = 1'b0;
		
end

endmodule
