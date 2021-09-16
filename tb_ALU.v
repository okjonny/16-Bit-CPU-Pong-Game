`timescale 1ns / 1ps  

module tb_ALU;

reg [15:0] A,B; // ALU 16-Bit Inputs
reg [7:0] Op;	// Op-code selection
reg cin;
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
    .Output(Output), // ALU 8-bit Output
	 .cin(cin)
);

initial begin
cin = 0;
A = 0;
B = 0;
/// set everything to zero
#10;
//for (i = 0; i <= 2** ; i=i+1)


//// Flags[1] - Low flag: 1 if Rb operand < Ra as UNSIGNED numbers
////Should overflow
//A = 12;
//B = 10;
//Op = 8'b00001011;
//#5
//$display("Should Overflow Op:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;
////Should not overflow
//A = 8;
//B = 10;
//Op = 8'b00001011;
//#5
//$display("No Overflow Op:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;
//
//
////Equality
//A = 3;
//B = 3;
//Op = 8'b00001011;
//#5
//$display("EqualOp:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;
//
////Arithmetic Overflow
////Two negatives
//A = $signed(16'b1111111111111111);
//B = $signed(16'b1111111111111111);
//Op = 8'b00001011;
//#5
//$display("Two Negatives Op:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;
////Two positives
//A = 32767;
//B = 32766;
//Op = 8'b00001011;
//#5
//$display("Two Postives Op:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;
//
//// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
////Should overflow
//A = 12;
//B = -10;
//Op = 8'b00001011;
//#5
//$display("SIGNED Should Overflow Op:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;
////Should not overflow
//A = -8;
//B = 10;
//Op = 8'b00001011;
//#5
//$display("SIGNED No Overflow Op:%b A:%b B:%b Output: %b Flags:%b", Op, A, B, Output, Flags);
//#5;


// OR Tests
//Op = 8'b00000010;
//for (i = 0; i <= 2**5; i = i + 1) begin
//	for (j = -2**5; j >= 0; j = j + 1) begin
//	
//		A = i;
//		B = j;
//		#5;
//		$display("A:%b B:%b Output:%b", A, B, Output);
//
//		if (Output != (A & B)) begin
//		#5;
//			$display("OR test failed.");
//		end
//	end
//end


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

// OR Test
A = 65535;
B = 10000;
Op = 8'b00000010;
#5;
if(Output == 16'b1111111111111111)
	$display("OR 1 - Passed");
else
	$display("Out:%b", Output);

#5;

A = 0;
B = 0;
Op = 8'b00000010;
#5;
if(Output == 16'b0000000000000000)
	$display("OR 2 - Passed");
else
	$display("Out:%b", Output);

//$display("A:%b B:%b Out:%b", A, B, Output);
#5;

A = 65535;
B = 1;
Op = 8'b00000010;
#5;
if(Output == 16'b1111111111111111)
	$display("OR 3 - Passed");
else
	$display("Out:%b", Output);


// AND Test
A = 40;
B = 100;
Op = 8'b00000001;
#5;
if(Output == 16'b0000000000100000)
	$display("AND 1 - Passed");
else
	$display("Out:%b", Output);
#5;

// XOR
A = 40;
B = 100;
Op = 8'b00000011;
#5;
if(Output == 16'b0000000001001100)
	$display("XOR 1 - Passed");
else
	$display("Out:%b", Output);
#5;


// XOR 2
A = 0;
B = 100;
Op = 8'b00000011;
#5;
if(Output == 16'b0000000001100100)
	$display("XOR 2 - Passed");
else
	$display("Out:%b", Output);
#5;


// XOR 3
A = 100;
B = 100;
Op = 8'b00000011;
#5;
if(Output == 16'b0000000000000000)
	$display("XOR 3 - Passed");
else
	$display("Out:%b", Output);
#5;

// ADD
A = 65535;
B = 100;
Op = 8'b00000101;
#5;
if(Output == 16'b0000000001100011 && Flags[0] == 1)
	$display("ADD Carry 1 - Passed");
else
	$display("Out:%b Carry:%b", Output, Flags[0]);
#5;

// ADD
A = 65435;
B = 100;
Op = 8'b00000101;
#5;
if(Output == 16'b1111111111111111 && Flags[0] == 0)
	$display("ADD Carry 2 - Passed");
else
	$display("Out:%b Carry:%b", Output, Flags[0]);
#5;


// LSH 1
A = 16'b0000000000100001;
B = 5;
Op = 8'b10000100;
#5;
if(Output == 16'b0000010000100000)
	$display("LSH 1 - Passed");
else
	$display("Out:%b", Output);
#5;

//LSH 2
A = 16'b0001000000100001;
B = 8;
Op = 8'b10000100;
#5;
if(Output == 16'b0010000100000000)
	$display("LSH 2 - Passed");
else
	$display("Out:%b", Output);
#5;

// LSH 3
A = 16'b0000000000000001;
B = 16;
Op = 8'b10000100;
#5;
if(Output == 16'b0000000000000000)
	$display("LSH 3 - Passed");
else
	$display("Out:%b", Output);
#5;

// ASHU 1
A = 16'b0001000000100001;
B = 16'b0000000000000000;
Op = 8'b10000110;
#5;
if(Output == 16'b0001000000100001)
	$display("ASHU 1 - Passed");
else
	$display("Out:%b", Output);
#5;

// ASHU 2
A = 16'b0001000000100001;
B = 16'b0000000000000001;
Op = 8'b10000110;
#5;
if(Output == 16'b0010000001000010)
	$display("ASHU 2 - Passed");
else
	$display("Out:%b", Output);
#5;

// ASHU 3
A = 16'b0001000000100001;
B = 16'b0000000000000111;
Op = 8'b10000110;
#5;
if(Output == 16'b0001000010000000)
	$display("ASHU 3 - Passed");
else
	$display("Out:%b", Output);
#5;

end

endmodule 