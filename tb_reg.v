`timescale 1ns / 1ps

module tb_reg;

//Inputs
reg reset, clock, enable;
reg [15:0] r; 
wire [15:0]out; 
int i;

 
//Outputs
 wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
 wire [15:0] ALU_Bus;
Regbank bank(.ALUBus(r),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15),.regEnable(enable),.clk(clock),.reset(reset));

initial begin 

ALUBus = 16'b1111000011110000; //0xF0F0

// initialize clock/reset
clock = 0;
enable = 1;
reset = 1;
enable = 0; 

// check reset registers
for (i = 0; i < 16; i = i + 1)
	begin
		$display("R[%d] = %d", i, r[i]);
	end
end


always #5 Clock = ~Clock; 


endmodule