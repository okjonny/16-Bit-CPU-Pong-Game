`timescale 1ns/1ps

module FSM_tb;
reg reset, clk;
wire [7:0] ALU_Op;
wire [7:0] mux_control;
wire [15:0] reg_enables, imm; 
integer i; 

Fib_Fsm uut(.clk(clk), .reset(reset), .alu_op(ALU_Op), .muxes(mux_control), .regs_en(reg_enables),.imm(imm));
initial begin
		clk = 0; #1;
		reset = 1; #1;
		clk = 1; #1;
		reset = 0; #1;
		clk = 0; #1;
		
		for (i = 0; i < 16; i = i + 1)
		begin
			clk = 1; #1;
			$display("alu_op: %b	muxes: %b, regs_en: %h	imm: %b", ALU_Op, mux_control, reg_enables, imm);
			clk = 0; #1;
		end
end
endmodule 