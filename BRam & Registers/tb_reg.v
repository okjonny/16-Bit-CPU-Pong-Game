`timescale 1ns / 1ps

module tb_reg;

//Inputs
reg reset, clock;
wire [15:0] r; 
integer i;
 
//Outputs
wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
reg [15:0] ALU_Bus, enable_register;
 
// Initializing Registers
RegBank uut(.ALUBus(ALU_Bus),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15),.regEnable(enable_register),.clk(clock),.reset(reset));

always #5 clock <= ~clock;
initial begin 
clock = 0; #1

// initialize clock/reset
enable_register = 0; 
reset = 1; #1

// TEST: RESET REGISTERS TO 0
	

// Test: REG ENABLE FOR r0, r15
//enable_register[0] = 1'b1; #1
//enable_register[15] = 1'b1; #1
//reset = 0; #1
//clock = 0; #1
//clock = 1; #1
//
//$display("R[0] = %d, R[15] = %d", r[0], r[15]);
//
//
// TEST: SET r0 = 111...111
// Reset full cycle
reset = 1; #1
reset = 0; #1
reset = 1; #1


ALU_Bus = 16'b1111111111111111;
enable_register[0] = 1'b1; #15
$display("r[0] = %d", r[0]);

reset = 1; #1
reset = 0; #1
reset = 1; #1

// TEST: SET DATA IN r0

end

endmodule 