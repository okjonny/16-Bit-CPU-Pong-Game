module FSM_RAM(clk, reset, Hex_output_1, Hex_output_2);
input reset, clk;
wire [15:0] data_a, data_b;
wire [9:0] addr_a, addr_b;
wire we_a, we_b;
wire [15:0] q_a, q_b;
output [6:0] Hex_output_1, Hex_output_2;
//output Hex_output_3, Hex_output_4;
//output [6:0] Hex_output_5, Hex_output_6, Hex_output_7, Hex_output_8;

bram_FSM states (.clk(clk),
					 .reset(reset),
					 .data_a(data_a),
					 .data_b(data_b),
					 .addr_a(addr_a),
					 .addr_b(addr_b),
					 .we_a(we_a),
					 .we_b(we_b));
					 
bram storage (.data_a(data_a),
				 .data_b(data_b),
				 .addr_a(addr_a),
				 .addr_b(addr_b),
				 .we_a(we_a),
				 .we_b(we_b),
				 .clk(clk),
				 .q_a(q_a),
				 .q_b(q_b));
				 

//hexTo7Seg fourth(.x(q_a[15:12]),.z(Hex_output_4));
//hexTo7Seg third(.x(q_a[11:8]),.z(Hex_output_3));
//hexTo7Seg second(.x(q_a[7:4]),.z(Hex_output_2));
hexTo7Seg first(.x(q_a[3:0]),.z(Hex_output_1));

//hexTo7Seg eighth(.x(q_b[15:12]),.z(Hex_output_8));
//hexTo7Seg seventh(.x(q_b[11:8]),.z(Hex_output_7));
//hexTo7Seg sixth(.x(q_b[7:4]),.z(Hex_output_6));
hexTo7Seg fifth(.x(q_b[3:0]),.z(Hex_output_2));

endmodule
