module decoder(instruction_in, instruction_out, R_dest, R_src, immediate, RI_out, instr_type, is_load);

input [15:0] instruction_in;

output reg [15:0] immediate;
output reg [7:0] instruction_out;
//output reg [3:0] R_dest, R_src;

//10/28/2021 REMOVE CIN, NO NEED NO MORE


//Exract registers from instruction
output reg [3:0] R_src;
//assign R_src = instruction_in[3:0];
output reg [3:0] R_dest;
//assign R_dest = instruction_in[11:8];

wire [7:0] op = {instruction_in[15:12], instruction_in[7:4]};

reg [7:0] ipad;
output reg RI_out; //0 is register, 1 is immediate for RI_out

//00 is R-Type, 01 is STORE, 10 is LOAD
output reg [1:0] instr_type;
output reg is_load = 0;

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
parameter LOAD =  8'b01000000;
parameter STORE = 8'b01000100;


//Implement LOAD and STOR later!
//parameter LOAD =  8'b01000000;
//parameter STOR =  8'b01000100;


always @(instruction_in, op, R_src, R_dest)
	begin 
		if(op == STORE || op == LOAD)
			begin
				R_src = instruction_in[11:8];
				R_dest = instruction_in[3:0];
			end
		else
			begin
				R_src = instruction_in[3:0];
				R_dest = instruction_in[11:8];
			end
			
		casex(op)
			ADD, SUB, OR, CMP, AND, XOR, MOV, LSH, ASHU:
				begin		
					instruction_out = op;
					ipad = 8'b00000000; 
					immediate = 16'b0000000000000000;
					RI_out = 0;
					instr_type = 2'b00;
					is_load = 0;
				end
				
			MUL:
				begin
					instruction_out = LSH;
					ipad = 8'b00000000;
					immediate = 16'b0000000000000000;
					RI_out = 0;
					instr_type = 2'b00;
					is_load = 0;
				end
				
			ADDI:
				begin
					instruction_out = ADD;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
					
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
			
			MULI:
				begin
					instruction_out = MUL;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
					
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
				
			SUBI:
				begin
					instruction_out = SUB;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
						
					immediate = {ipad, ~instruction_in[7:4], ~R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
			
			CMPI:
				begin
					instruction_out = CMP;
					if(instruction_in[7] == 1)
						ipad = 8'b11111111;
					else
						ipad = 8'b00000000;
					
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
				
			ANDI:
				begin
					instruction_out = AND;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
				end
			
			ORI:
				begin
					instruction_out = OR;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
			
			XORI:
				begin
					instruction_out = XOR;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
				
			MOVI:
				begin
					instruction_out = MOV;
					ipad = 8'b00000000;
					immediate = {ipad, instruction_in[7:4], R_src};
					RI_out = 1;
					instr_type = 2'b00;
					is_load = 0;
				end
				
			STORE:
				begin
					instruction_out = 8'b00000000;
					ipad = 8'b00000000;
					immediate = 16'b0000000000000000;
					RI_out = 0;
					instr_type = 2'b01;
					is_load = 0;
				end
				
			LOAD:
				begin
					instruction_out = 8'b00000000;
					ipad = 8'b00000000;
					immediate = 16'b0000000000000000;
					RI_out = 0;
					instr_type = 2'b10;
					is_load = 1;
				end
			
			default:
				begin
					instruction_out = 8'b00000000;
					ipad = 8'b00000000;
					immediate = 16'b0000000000000000;
					RI_out = 1;
					instr_type = 2'bxx;
					is_load = 0;
				end
		endcase
	end

endmodule 