module decoder(instruction_in, instruction_out, R_dest, R_src, immediate, c_in, RI_out, d_type);

input [15:0] instruction_in;

output reg [15:0] immediate;
output reg [7:0] instruction_out;
//output reg [3:0] R_dest, R_src;

//10/28/2021 REMOVE CIN, NO NEED NO MORE


//Exract registers from instruction
output [3:0] R_src;
assign R_src = instruction_in[3:0];
output [3:0] R_dest;
assign R_dest = instruction_in[11:8];

wire [7:0] op = {instruction_in[15:12], instruction_in[7:4]};

reg [7:0] ipad;
output reg c_in, RI_out; //0 is register, 1 is immediate for RI_out
output d_type;
assign d_type = (instruction_in[15:12] == 4'b0100);

// Parameter Defintions:
parameter ADD = 	8'b00000101;
parameter SUB =   8'b00001001;
parameter MUL =   8'b00001110;
parameter OR = 	8'b00000010;
parameter CMP = 	8'b00001011;
parameter AND = 	8'b00000001;
parameter XOR = 	8'b00000011;
parameter MOV = 	8'b00001101;
parameter LSH = 	8'b10000100;
parameter ASHU = 	8'b10000110;
parameter ADDI =  8'b0101xxxx;
parameter MULI =  8'b1110xxxx;
parameter SUBI =  8'b1001xxxx;
parameter CMPI = 	8'b1011xxxx;
parameter ANDI = 	8'b0001xxxx;
parameter ORI = 	8'b0010xxxx;
parameter XORI = 	8'b0011xxxx;
parameter MOVI = 	8'b1101xxxx;
parameter LSHI = 	8'b1000xxxx;
parameter LUI = 	8'b1111xxxx;



//Implement LOAD and STOR later!
//parameter LOAD =  8'b01000000;
//parameter STOR =  8'b01000100;


always @(instruction_in, op)
	begin 
		casex(op)
			ADD, SUB, OR, CMP, AND, XOR, MOV, LSH, ASHU:
				begin		
					instruction_out = op;
					c_in = 0;
					ipad = 8'b00000000; 
					immediate = 16'b0000000000000000;
					RI_out = 0;
				end
				
			MUL:
				begin
					instruction_out = LSH;
					c_in = 0;
					ipad = 8'b00000000;
					immediate = 16'b0000000000000000;
					RI_out = 0;
				end
				
			ADDI:
				begin
					instruction_out = ADD;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
					
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
			
			MULI:
				begin
					instruction_out = MUL;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
					
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
				
			SUBI:
				begin
					instruction_out = ADD;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
						
					immediate = {ipad, ~instruction_in[7:4], ~R_src};
					c_in = 1;
					RI_out = 1;
				end
			
			CMPI:
				begin
					instruction_out = CMP;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
					
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
				
			ANDI:
				begin
					instruction_out = AND;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
			
			ORI:
				begin
					instruction_out = OR;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
			
			XORI:
				begin
					instruction_out = XOR;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
				
			MOVI:
				begin
					instruction_out = MOV;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					c_in = 0;
					RI_out = 1;
				end
			
//			LSHI:
//				begin
//					instruction_out = LSH;
//					ipad = 8'b00000000;
//					immediate = {ipad, instruction_in[7:4], R_src}
//					c_in = 0;
//				end

//			LUI:
//				begin
//					instruction_out = ?; Left shift by 8 then load...
//					ipad = 8'b00000000;
//					immediate = {ipad, instruction_in[7:4], R_src}
//					c_in = 0;
//				end
			
			default:
				begin
					instruction_out = 8'b00000000;
					ipad = 8'b00000000;
					immediate = 16'b0000000000000000;
					c_in = 0;
					RI_out = 1;
				end
		endcase
	end

endmodule 