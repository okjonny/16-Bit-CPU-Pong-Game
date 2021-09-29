module Fib_Fsm(clk, reset, alu_op, muxes, regs_en, imm);
	input clk, reset;
	output reg [7:0] alu_op;
	output reg [7:0] muxes; //2 muxes, each 4 bits to choose the register
	output reg [15:0] regs_en; 
	output reg [15:0] imm;
	
	parameter [3:0] S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, 
		S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111,
		S8 = 4'b1000, S9 = 4'b1001, S10 = 4'b1010, S11 = 4'b1011, 
		S12 = 4'b1100, S13 = 4'b1101, S14 = 4'b1110, S15 = 4'b1111;
	
	reg [3:0] state = S0; // y
	wire [3:0] nextState; // Y
	
	
	// DFF
	always @(posedge clk)
		if (~reset)
			state <= S0;
		else
			state <= nextState;
	
	// Next state logic
	assign nextState = (state == S15) ? state : state + 4'b0001;

	
	// Define output
	always @(state)
	begin
		case (state)
			 S0: begin alu_op = 8'hxx; muxes = 8'h00; regs_en = 16'h0000; imm = 16'hxxxx; end // Reset (dont write) (shows 0)
			 S1: begin alu_op = 8'h50; muxes = 8'h10; regs_en = 16'h0002; imm = 16'h0001; end // addi to R1 (shows 1)
			 S2: begin alu_op = 8'h05; muxes = 8'h01; regs_en = 16'h0004; imm = 16'hxxxx; end // add R2, R0, R1 (shows 1)
			 S3: begin alu_op = 8'h05; muxes = 8'h12; regs_en = 16'h0008; imm = 16'hxxxx; end // add R3, R1, R2 (shows 2)
		    S4: begin alu_op = 8'h05; muxes = 8'h23; regs_en = 16'h0010; imm = 16'hxxxx; end // add R4, R2, R3 (shows 3)
			 S5: begin alu_op = 8'h05; muxes = 8'h34; regs_en = 16'h0020; imm = 16'hxxxx; end // add R5, R3, R4 (shows 5)
			 S6: begin alu_op = 8'h05; muxes = 8'h45; regs_en = 16'h0040; imm = 16'hxxxx; end // add R6, R4, R5 (shows 8)
			 S7: begin alu_op = 8'h05; muxes = 8'h56; regs_en = 16'h0080; imm = 16'hxxxx; end // add R7, R5, R6 (shows 13)
			 S8: begin alu_op = 8'h05; muxes = 8'h67; regs_en = 16'h0100; imm = 16'hxxxx; end // add R8, R6, R7 (shows 21)
			 S9: begin alu_op = 8'h05; muxes = 8'h78; regs_en = 16'h0200; imm = 16'hxxxx; end // add R9, R7, R8 (shows 34)
			S10: begin alu_op = 8'h05; muxes = 8'h89; regs_en = 16'h0400; imm = 16'hxxxx; end // add R10, R8, R9 (shows 55)
			S11: begin alu_op = 8'h05; muxes = 8'h9a; regs_en = 16'h0800; imm = 16'hxxxx; end // add R11, R9, R10 (shows 89)
			S12: begin alu_op = 8'h05; muxes = 8'hab; regs_en = 16'h1000; imm = 16'hxxxx; end // add R12, R10, R11 (shows 144)
			S13: begin alu_op = 8'h05; muxes = 8'hbc; regs_en = 16'h2000; imm = 16'hxxxx; end // add R13, R11, R12 (shows 233)
		   S14: begin alu_op = 8'h05; muxes = 8'hcd; regs_en = 16'h4000; imm = 16'hxxxx; end // add R14, R12, R13 (shows 377)
			S15: begin alu_op = 8'h05; muxes = 8'hde; regs_en = 16'h8000; imm = 16'hxxxx; end // add R15, R13, R14 (shows 610) and stay here until reset.
			default: begin alu_op = 8'hxx; muxes = 8'hxx; regs_en = 16'hxxxx; imm = 16'hxxxx; end
		endcase	
	end
	
endmodule
