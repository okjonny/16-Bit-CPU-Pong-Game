module vga_display (
	input	clk, rst,
	output hsync, vsync,
	output reg vga_blank_n, vga_clk,
	output reg [9:0] hcount, vcount,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
);

reg [3:0] r_red = 4'b0;
reg [3:0] r_green = 4'b0;
reg [3:0] r_blue = 4'b0;
reg count;

// parameters for a VGA 640 x 480 (60Hz) display
// dropping our 50MHz clock to a 25MHz pixel clock

parameter H_SYNC        = 10'd95;  // 3.8us  -- 25M * 3.8u  = 95
parameter H_BACK_PORCH  = 10'd48;  // 1.9us  -- 25M * 1.9u  = 47.5
parameter H_DISPLAY_INT = 10'd635; // 25.4us -- 25M * 25.4u = 635
parameter H_FRONT_PORCH = 10'd15;  // 0.6us  -- 25M * 0.6u  = 15
parameter H_TOTAL       = 10'd793; // total width -- 95 + 48 + 635 + 15 = 793

parameter V_SYNC        = 10'd2;   // 2 lines
parameter V_BACK_PORCH  = 10'd33;  // 33 lines
parameter V_DISPLAY_INT = 10'd480; // 480 lines
parameter V_FRONT_PORCH = 10'd10;  // 10 lines
parameter V_TOTAL       = 10'd525; // total width -- 2 + 33 + 480 + 10 = 525

assign hsync = ~((hcount >= H_FRONT_PORCH) & (hcount < H_FRONT_PORCH + H_SYNC));
assign vsync = ~((vcount >= V_DISPLAY_INT + V_FRONT_PORCH) & (vcount < V_DISPLAY_INT + V_FRONT_PORCH + V_SYNC));

assign r = 4'b1111;
assign g = 4'b1111;
assign b = 4'b1111;

always @(posedge clk) begin
	
	if (rst) begin
		vcount  <= 10'd0;
		hcount  <= 10'd0;
		count   <= 1'b0;
		vga_clk <= 1'b0;
	end
	
	else if (count) begin
		hcount = hcount + 1'b1;
		
		// clear if reaches end
		if (hcount == H_TOTAL) begin
			hcount = 10'd0;
			vcount = vcount + 1'b1;
			
			if (vcount == V_TOTAL)
				vcount = 10'd0;
		end
	end
	
	vga_clk <= ~vga_clk; // generates 25MHz vga_clk
	count   <= ~count;
end

always @(hcount,vcount) begin
	
	// bright
	if ((hcount >= H_BACK_PORCH + H_SYNC + H_FRONT_PORCH) &&
		 (hcount < H_TOTAL - H_FRONT_PORCH) &&
		 (vcount < V_DISPLAY_INT))
		 vga_blank_n = 1'b1;
	 
	 else 
		vga_blank_n = 1'b0;
		
end

//// THIS IS NOT MY CODE!!!!! USESD FOR TESTING PURPROSES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	// pattern generate
//		always @ (posedge clk)
//		begin
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
//			if (vcount < 135)
//				begin              
//					r_red <= 4'hF;    // white
//					r_blue <= 4'hF;
//					r_green <= 4'hF;
//				end  // if (vcount < 135)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1
//			
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
//			else if (vcount >= 135 && vcount < 205)
//				begin 
//					if (hcount < 324)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // if (hcount < 324)
//					else if (hcount >= 324 && hcount < 604)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 324 && hcount < 604)
//					else if (hcount >= 604)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 604)
//					end  // else if (vcount >= 135 && vcount < 205)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 2
//			
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 3
//			else if (vcount >= 205 && vcount < 217)
//				begin 
//					if (hcount < 324)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // if (hcount < 324)
//					else if (hcount >= 324 && hcount < 371)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 324 && hcount < 371)
//					else if (hcount >= 371 && hcount < 383)
//						begin 
//							r_red <= 4'h0;    // black
//							r_blue <= 4'h0;
//							r_green <= 4'h0;
//						end  // else if (hcount >= 371 && hcount < 383)
//					else if (hcount >= 383 && hcount < 545)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 383 && hcount < 545)
//					else if (hcount >= 545 && hcount < 557)
//						begin 
//							r_red <= 4'h0;    // black
//							r_blue <= 4'h0;
//							r_green <= 4'h0;
//						end  // else if (hcount >= 545 && hcount < 557)
//					else if (hcount >= 557 && hcount < 604)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 557 && hcount < 604)
//					else if (hcount >= 604)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 604)
//				end  // else if (vcount >= 205 && vcount < 217)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3
//			
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
//			else if (vcount >= 217 && vcount < 305)
//				begin
//					if (hcount < 324)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // if (hcount < 324)
//					else if (hcount >= 324 && hcount < 604)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 324 && hcount < 604)
//					else if (hcount >= 604)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 604)	
//				end  // else if (vcount >= 217 && vcount < 305)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 4
//			
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
//			else if (vcount >= 305 && vcount < 310)
//				begin
//					if (hcount < 324)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // if (hcount < 324)
//					else if (hcount >= 324 && hcount < 371)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 324 && hcount < 371)
//					else if (hcount >= 371 && hcount < 557)
//						begin 
//							r_red <= 4'h0;    // black
//							r_blue <= 4'h0;
//							r_green <= 4'h0;
//						end  // else if (hcount >= 371 && hcount < 557)
//					else if (hcount >= 557 && hcount < 604)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 557 && hcount < 604)
//					else if (hcount >= 604)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 604)	
//				end  // else if (vcount >= 217 && vcount < 305)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 5
//			
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 6
//			else if (vcount >= 305 && vcount < 414)
//				begin
//					if (hcount < 324)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // if (hcount < 324)
//					else if (hcount >= 324 && hcount < 604)
//						begin 
//							r_red <= 4'hF;    // yellow
//							r_blue <= 4'h0;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 324 && hcount < 604)
//					else if (hcount >= 604)
//						begin 
//							r_red <= 4'hF;    // white
//							r_blue <= 4'hF;
//							r_green <= 4'hF;
//						end  // else if (hcount >= 604)	
//				end  // else if (vcount >= 305 && vcount < 414)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 6
//			
//			////////////////////////////////////////////////////////////////////////////////////// SECTION 7
//			else if (vcount <= 414)
//				begin              
//					r_red <= 4'hF;    // white
//					r_blue <= 4'hF;
//					r_green <= 4'hF;
//				end  // if (vcount >= 414)
//			////////////////////////////////////////////////////////////////////////////////////// END SECTION 7
//		end  // always
//						
	// end pattern generate

// Update RGB Values 
//assign r = ((hcount > H_SYNC + H_BACK_PORCH + H_FRONT_PORCH)  && (vcount > V_SYNC + V_BACK_PORCH + V_FRONT_PORCH)) ? r_red : 4'h0;
//assign g = ((hcount > H_SYNC + H_BACK_PORCH + H_FRONT_PORCH)  && (vcount > V_SYNC + V_BACK_PORCH + V_FRONT_PORCH)) ? r_green : 4'h0;
//assign b = ((hcount > H_SYNC + H_BACK_PORCH + H_FRONT_PORCH)  && (vcount > V_SYNC + V_BACK_PORCH + V_FRONT_PORCH)) ? r_blue: 4'h0;




endmodule //vga_display