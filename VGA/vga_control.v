module vga_control (
    input clk,
    output vertical_sync,
    output horizontal_sync,
    output reg vga_blank_n,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
);

wire clk_div_25;
wire enable_vertical_count;
wire [15:0] vertical_count;
wire [15:0] horizontal_count;

reg [3:0] r_red = 4'b0;
reg [3:0] r_blue = 4'b0;
reg [3:0] r_green = 4'b0;

clock_divider clock_25_d(.clk(clk), .div_clk(clk_div_25));
horizontal_vga_counter h_count(.clk_div(clk_div_25), .horizontal_count(horizontal_count), .enable_vertical_count(enable_vertical_count));
vertical_vga_counter v_count(.clk_div(clk_div_25), .enable_vertical_count(enable_vertical_count), .vertical_count(vertical_count));

//outputs
assign horizontal_sync = (horizontal_count < 96) ? 1'h1 : 1'h0;
assign vertical_sync = (vertical_count < 2)      ? 1'h1 : 1'h0;

// THIS IS NOT MY CODE!!!!! USESD FOR TESTING PURPROSES
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// pattern generate
		always @ (posedge clk)
		begin
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
			if (vertical_count < 135)
				begin              
					r_red <= 4'hF;    // white
					r_blue <= 4'hF;
					r_green <= 4'hF;
				end  // if (vertical_count < 135)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
			else if (vertical_count >= 135 && vertical_count < 205)
				begin 
					if (horizontal_count < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // if (horizontal_count < 324)
					else if (horizontal_count >= 324 && horizontal_count < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 324 && horizontal_count < 604)
					else if (horizontal_count >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 604)
					end  // else if (vertical_count >= 135 && vertical_count < 205)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 2
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 3
			else if (vertical_count >= 205 && vertical_count < 217)
				begin 
					if (horizontal_count < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // if (horizontal_count < 324)
					else if (horizontal_count >= 324 && horizontal_count < 371)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 324 && horizontal_count < 371)
					else if (horizontal_count >= 371 && horizontal_count < 383)
						begin 
							r_red <= 4'h0;    // black
							r_blue <= 4'h0;
							r_green <= 4'h0;
						end  // else if (horizontal_count >= 371 && horizontal_count < 383)
					else if (horizontal_count >= 383 && horizontal_count < 545)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 383 && horizontal_count < 545)
					else if (horizontal_count >= 545 && horizontal_count < 557)
						begin 
							r_red <= 4'h0;    // black
							r_blue <= 4'h0;
							r_green <= 4'h0;
						end  // else if (horizontal_count >= 545 && horizontal_count < 557)
					else if (horizontal_count >= 557 && horizontal_count < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 557 && horizontal_count < 604)
					else if (horizontal_count >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 604)
				end  // else if (vertical_count >= 205 && vertical_count < 217)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			else if (vertical_count >= 217 && vertical_count < 305)
				begin
					if (horizontal_count < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // if (horizontal_count < 324)
					else if (horizontal_count >= 324 && horizontal_count < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 324 && horizontal_count < 604)
					else if (horizontal_count >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 604)	
				end  // else if (vertical_count >= 217 && vertical_count < 305)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 4
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (vertical_count >= 305 && vertical_count < 310)
				begin
					if (horizontal_count < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // if (horizontal_count < 324)
					else if (horizontal_count >= 324 && horizontal_count < 371)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 324 && horizontal_count < 371)
					else if (horizontal_count >= 371 && horizontal_count < 557)
						begin 
							r_red <= 4'h0;    // black
							r_blue <= 4'h0;
							r_green <= 4'h0;
						end  // else if (horizontal_count >= 371 && horizontal_count < 557)
					else if (horizontal_count >= 557 && horizontal_count < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 557 && horizontal_count < 604)
					else if (horizontal_count >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 604)	
				end  // else if (vertical_count >= 217 && vertical_count < 305)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 5
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 6
			else if (vertical_count >= 305 && vertical_count < 414)
				begin
					if (horizontal_count < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // if (horizontal_count < 324)
					else if (horizontal_count >= 324 && horizontal_count < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 324 && horizontal_count < 604)
					else if (horizontal_count >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  // else if (horizontal_count >= 604)	
				end  // else if (vertical_count >= 305 && vertical_count < 414)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 6
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 7
			else if (vertical_count <= 414)
				begin              
					r_red <= 4'hF;    // white
					r_blue <= 4'hF;
					r_green <= 4'hF;
				end  // if (vertical_count >= 414)
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 7
		end  // always
						
	// end pattern generate

    always @(horizontal_count, vertical_count) begin
    if ((horizontal_count >= 96 && horizontal_count <= 144) &&
         (horizontal_count>= 784 && horizontal_count <= 799) &&
         (vertical_count >= 2 && vertical_count <= 35))&&
         (vertical_count >= 515 && vertical_count <= 524)
         vga_blank_n = 1'b1;
     
     else 
        vga_blank_n = 1'b0;
end

// Update RGB Values 
assign r = (horizontal_count < 784 && horizontal_count > 144 && vertical_count < 515 && vertical_count > 35) ? r_red : 4'h0;
assign g = (horizontal_count < 784 && horizontal_count > 144 && vertical_count < 515 && vertical_count > 35) ? r_green : 4'h0;
assign b = (horizontal_count < 784 && horizontal_count > 144 && vertical_count < 515 && vertical_count > 35) ? r_blue: 4'h0;


endmodule //vga_control