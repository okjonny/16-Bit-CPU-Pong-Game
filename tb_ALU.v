`timescale 1ns / 1ps  

module tb_ALU;
//Inputs
 reg[3:0] A,B;
 reg[1:0] ALU_Sel;

//Outputs
 wire[3:0] ALU_Out;
 
 // Verilog code for ALU
 ALU uut(
    .A(A),
	 .B(B),  // ALU 8-bit Inputs                 
    .ALU_Sel(ALU_Sel),// ALU Selection
    .ALU_Out(ALU_Out) // ALU 8-bit Output
);

initial begin
// hold reset state for 100 ns.
A = 5;
B = 6;
ALU_Sel = 0;
#5
$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
#5;

A = 5;
B = 6;
ALU_Sel = 1;
#5
$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
#5;


A = 5;
B = 6;
ALU_Sel = 2;
#5
$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
#5;


A = 5;
B = 6;
ALU_Sel = 3;
#5
$display("A:%b B:%b ALU_Sel:%b ALU_Out:%b", A, B, ALU_Sel, ALU_Out);
#5;


      
      
end
endmodule 