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
		clk = 0; #20;
		reset = 1; #20;
		clk = 1; #20; // completes state zero
		reset = 0; #20;
		
		$display("Data A: %b, Data B: %b, Reg A: %b, Reg B : %b, Output A: %b, Output B: %b", data_a, data_b, addr_a, addr_b, q_a, q_b);

		clk = 0; #20;
		reset = 1; #20;
		clk = 1; #20;
		
//		for (i = 0; i < 16; i = i + 1)
//		begin
//			clk = 1; #1;
//			$display("alu_op: %b	muxes: %b, regs_en: %h	imm: %b output: %b", ALU_Op, mux_control, reg_enables, imm, ALU_output);
//			clk = 0; #1;	
//		end
end







endmodule 