module ALU(A, B, Op, Flags, cin, Output);

input [15:0] A,B; // ALU 16-Bit Inputs
input [7:0] Op;	// Op-code selection
input cin;

// Flags[0] - Carry-bit
// Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
// Flags[2] - Flag: F bit to signal arithmetic overflow
// Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
output reg [4:0] Flags;

output reg [15:0] Output;

// Parameter Defintions:
parameter ADD = 	8'b00000101;
parameter SUB =   8'b00001001;
parameter OR = 	8'b00000010;
parameter CMP = 	8'b00001011;
parameter AND = 	8'b00000001;
parameter XOR = 	8'b00000011;
parameter MOV = 	8'b00001101;
parameter LSH = 	8'b10000100;
parameter ASHU = 	8'b10000110;

always @(A, B, cin, Op)
	begin
		case(Op)
		//  Add and Subtract Case
		ADD: 
		begin		
			{Flags[0], Output} = A + B + cin; //+ Flags[0]; // Flags[0] - Carry-bit, Can't add Flag[0] ASK SAM
			Flags[1] = 1'bx;
			Flags[2] = 1'bx;
			Flags[3] = Output == 0;
			Flags[4] = Output[15];
		end
		SUB:
		begin
			//Rdest = Rdest - Rsrc
			Output = B - A; //+ Flags[0]; // Flags[0] - Carry-bit, Can't add Flag[0] ASK SAM
			Flags[0] = 1'bx;
			Flags[1] = 1'bx;
			Flags[2] = 1'bx;
			Flags[3] = Output == 0;
			Flags[4] = Output[15];
		end
		OR: 
		begin
			Output = A | B;
			Flags[0] = 1'bx;
			Flags[1] = 1'bx;
			Flags[2] = 1'bx;
			Flags[3] = Output == 0;
			Flags[4] = 1'bx;
		end
		
		AND:
			begin
				Output = A & B;
				Flags[0] = 1'bx;
				Flags[1] = 1'bx;
				Flags[2] = 1'bx;
				Flags[3] = Output == 0;
				Flags[4] = 1'bx;
			end
			
		XOR:
			begin
				Output = A ^ B;
				Flags[0] = 1'bx;
				Flags[1] = 1'bx;
				Flags[2] = 1'bx;
				Flags[3] = Output == 0;
				Flags[4] = 1'bx;
			end
		CMP:
		begin
			//Add for checks
			Output = A + B;
			Flags[0] = 1'bx;
			
			// Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
			if(B < A)
				Flags[1] = 1;
			else
				Flags[1] = 0;//1'bx for don't care
				
			// Flags[2] - Flag: F bit to signal arithmetic overflow
			if((A[15] == 0 && B[15] == 0 && Output[15] == 1) ||
				A[15] == 1 && B[15] == 1 && Output[15] == 0) //arithmetic overflow
				Flags[2] = 1;
			else
				Flags[2] = 0;
				
			// Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
			if(A == B)
				Flags[3] = 1;
			else
				Flags[3] = 0;
				
			// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
			if($signed(B) < $signed(A))
				Flags[4] = 1;
			else
				Flags[4] = 0;
		end
		
		LSH:
			begin
				// negative case
				if(B[15] == 1)
					Output = A >> (~B + 1);
				else
					Output = A << B;
				
				
				Flags[0] = 1'bx;
				Flags[1] = 1'bx;
				Flags[2] = 1'bx;
				Flags[3] = Output == 0;
				Flags[4] = 1'bx;
			end
				
		ASHU:
			begin
				if(B[15] == 1)
					Output = $signed(A) >>> (~B + 1);
				else
					Output = $signed(A) <<< B;
				
				Flags[0] = 1'bx;
				Flags[1] = 1'bx;
				Flags[2] = 1'bx;
				Flags[3] = Output == 0;
				Flags[4] = 1'bx;
			end
			
		default:
			begin
				Output = 16'b0;
				Flags[0] = 1'bx;
				Flags[1] = 1'bx;
				Flags[2] = 1'bx;
				Flags[3] = 1'bx;
				Flags[4] = 1'bx;
			end
		endcase
	end
endmodule
		
		