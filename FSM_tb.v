`timescale 1ns/1ps

module FSM_tb;
reg reset, clk;
wire [7:0] ALU_Op;
wire [7:0] mux_control;
wire [15:0] reg_enables, imm;
wire [4:0] flag_reg;
wire [15:0] ALU_output;
integer i;

//Fib_Fsm uut(.clk(clk), .reset(reset), .alu_op(ALU_Op), .muxes(mux_control), .regs_en(reg_enables),.imm(imm));
FSM_ALU uut(.clk(clk), .reset(reset), .flag_reg(flag_reg), .ALU_output(ALU_output));

initial begin
		clk = 0; #20;
		reset = 1; #20;
		clk = 1; #20;
		reset = 0; #20;
		clk = 0; #20;
		reset = 1; #20;
		
		for (i = 0; i < 16; i = i + 1)
		begin
			clk = 1; #1;
			$display("alu_op: %b	muxes: %b, regs_en: %h	imm: %b output: %b", ALU_Op, mux_control, reg_enables, imm, ALU_output);
//			$display("Output: %b	", ALU_output);

			clk = 0; #1;	
		end
end
endmodule 