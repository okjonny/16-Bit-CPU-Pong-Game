`timescale 1ns/1ps

module tb_bram;
reg reset, clk;
wire [15:0] data_a, data_b;
wire [9:0] addr_a, addr_b;
wire we_a,we_b;
wire [15:0] q_a, q_b;

integer i;

bram_FSM states(.clk(clk),
					 .reset(reset),
					 .data_a(data_a),
					 .data_b(data_b),
					 .addr_a(addr_a),
					 .addr_b(addr_b),
					 .we_a(we_a),
					 .we_b(we_b));
					 
bram storage(.data_a(data_a),
				 .data_b(data_b),
				 .addr_a(addr_a),
				 .addr_b(addr_b),
				 .we_a(we_a),
				 .we_b(we_b),
				 .clk(clk),
				 .q_a(q_a),
				 .q_b(q_b));

initial begin
		// Write (A = 8, B = 10)
		clk = 0; #20;
		clk = 1; #20; // completes state zero
		clk = 0; #20;
		$display("Data A: %d, Data B: %d, Reg A: %d, Reg B : %d, Output A: %d, Output B: %d", data_a, data_b, addr_a, addr_b, q_a, q_b);

		// Read (A = 8, B = 10)
		clk = 1; #20;
		clk = 0; #20;
		$display("Data A: %d, Data B: %d, Reg A: %d, Reg B : %d, Output A: %d, Output B: %d", data_a, data_b, addr_a, addr_b, q_a, q_b);

		// Modify (A += 1, B += 1, so A = 9, B = 11)
		clk = 1; #20;
		clk = 0; #20;
		$display("Data A: %d, Data B: %d, Reg A: %d, Reg B : %d, Output A: %d, Output B: %d", data_a, data_b, addr_a, addr_b, q_a, q_b);

		// Write (A=32, B=18)
		clk = 1; #20;
		clk = 0; #20;
		$display("Data A: %d, Data B: %d, Reg A: %d, Reg B : %d, Output A: %d, Output B: %d", data_a, data_b, addr_a, addr_b, q_a, q_b);

		// Read (A=32, B=18)
		clk = 1; #20;
		clk = 0; #20;
		$display("Data A: %d, Data B: %d, Reg A: %d, Reg B : %d, Output A: %d, Output B: %d", data_a, data_b, addr_a, addr_b, q_a, q_b);

		// Verify (Basically reading what we had stored in S2 to see it's unchanged, (A=9, B=11)
		clk = 1; #20;
		clk = 0; #20;
		$display("Data A: %d, Data B: %d, Reg A: %d, Reg B : %d, Output A: %d, Output B: %d", data_a, data_b, addr_a, addr_b, q_a, q_b);

//		for (i = 0; i < 16; i = i + 1)
//		begin
//			clk = 1; #1;
//			$display("alu_op: %b	muxes: %b, regs_en: %h	imm: %b output: %b", ALU_Op, mux_control, reg_enables, imm, ALU_output);
//			clk = 0; #1;	
//		end
end







endmodule 