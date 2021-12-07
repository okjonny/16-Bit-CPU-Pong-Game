`timescale 1ns / 1ps
// each instruction run occurs by one clock 
module Register(D_in, wEnable, reset, clk, r);
	 input [15:0] D_in;
	 input clk, wEnable, reset;
	 output reg [15:0] r;
	 
	 // Asynchro. reset 
 always @( posedge clk, negedge reset)
	begin
	if (~reset) r <= 16'b0000000000000000;
	else
		begin			
			if (wEnable)
				begin
					r <= D_in;
				end
			else
				begin
					r <= r;
				end
		end
	end
endmodule

// Shown below is one way to implement the register file
// This is a bottom-up, structural instantiation
// Another module is described in another file...
// .... which shows two dimensional construct for regfile

// Structural Implementation of RegBank
/********/
module RegBank(ALUBus, nes_input, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regEnable, clk, reset);
	input clk, reset;
	input [15:0] ALUBus;
	input [15:0] regEnable;
	input [15:0] nes_input;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;

Register Inst0(
	.D_in(ALUBus),
	.wEnable(regEnable[0]),
	.reset(reset), 
	.clk(clk),
	.r(r0));
Register Inst1(ALUBus, regEnable[1], reset, clk, r1);
Register Inst2(ALUBus, regEnable[2], reset, clk, r2);
Register Inst3(ALUBus, regEnable[3], reset, clk, r3);
Register Inst4(ALUBus, regEnable[4], reset, clk, r4);
Register Inst5(ALUBus, regEnable[5], reset, clk, r5);
Register Inst6(ALUBus, regEnable[6], reset, clk, r6);
Register Inst7(ALUBus, regEnable[7], reset, clk, r7);
Register Inst8(ALUBus, regEnable[8], reset, clk, r8);
Register Inst9(ALUBus, regEnable[9], reset, clk, r9);
Register Inst10(ALUBus, regEnable[10], reset, clk, r10);
Register Inst11(ALUBus, regEnable[11], reset, clk, r11);
Register Inst12(ALUBus, regEnable[12], reset, clk, r12);
Register Inst13(ALUBus, regEnable[13], reset, clk, r13);
Register Inst14(ALUBus, regEnable[14], reset, clk, r14);
Register Inst15(nes_input, 1'b1, reset, clk, r15);
endmodule 