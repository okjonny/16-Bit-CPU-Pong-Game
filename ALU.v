module ALU(A, B, Op, Flag, Output);

input [15:0] A,B; // ALU 16-Bit Inputs
input [7:0] Op;	// Op-code selection


// Flags[0] - Carry-bit
// Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
// Flags[2] - Flag: F bit to signal arithmetic overflow
// Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
output wire [4:0] Flags;

// Parameter Defintions:
parameter ADD = 8'b00000101;
parameter OR = 8'b00000010;

always @(A,B,Op)
	begin
		case(Op)
		