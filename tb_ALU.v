`timescale 1ns / 1ps  

module tb_ALU;

reg [15:0] A,B; // ALU 16-Bit Inputs
reg [7:0] Op;	// Op-code selection
integer i,j;


// Flags[0] - Carry-bit
// Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
// Flags[2] - Flag: F bit to signal arithmetic overflow
// Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
wire [4:0] Flags;

wire [15:0] Output;
 // Verilog code for ALU
 ALU uut(
    .A(A),
	 .B(B),  // ALU 8-bit Inputs                 
    .Op(Op),// ALU Selection
	 .Flags(Flags),
    .Output(Output) // ALU 8-bit Output
);

initial begin
// OR Tests
Op = 8'b00000010;
for (i = 0; i <= 2**5; i = i + 1) begin
	for (j = -2**5; j >= 0; i = i + 1) begin
		{A} = i;
		{B} = j;
		if (Output != (A & B)) begin
			$display("OR test failed.");
		end
	end
end
//#5;
//$display("A:%b B:%b OP:%b Flags:%b Output:%b", A, B, Op, Flags, Output);
//#5;
//
//A = 5;
//B = 6;
//ALU_Sel = 1;
//#5
//$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
//#5;
//
//
//A = 5;
//B = 6;
//ALU_Sel = 2;
//#5
//$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
//#5;
//
//
//A = 5;
//B = 6;
//ALU_Sel = 3;
//#5
//$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
//#5;


      
      
end
endmodule 