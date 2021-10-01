module Fib_Fsm(clk, reset, alu_op, muxA, muxB, regs_en, imm, buff_en, imm_control);
	input clk, reset;
	output reg [7:0] alu_op;
	output reg [4:0] muxA;
	output reg [4:0] muxB;
	output reg [15:0] regs_en; 
	output reg [15:0] imm;
	output reg buff_en;
	output reg imm_control;
	
	reg [3:0] state; 
	reg [3:0] nextState; 
	
	parameter [3:0] S0 = 4'b0000, S1 = 4'b0001, 
		S2 = 4'b0010, S3 = 4'b0011, 
		S4 = 4'b0100, S5 = 4'b0101;
	always @(negedge clk) begin
		state <= nextState;
	end
	
	always @(posedge clk, negedge reset)begin
		if (!reset)
			nextState <= S0;
		else begin
			case(state)
				S0: nextState <= S1;
				S1: nextState <= S2;
				S2: nextState <= S3;
				S3: nextState <= S4;
				S4: nextState <= S5;
				S5: nextState <= S5;
			default: nextState <= S0;
			endcase
			end
		end
		
	always @(state)
	begin
		case (state)
			 S0: begin alu_op = 0; muxA = 0; muxB = 0; regs_en = 0; imm = 0; buff_en = 1	; imm_control = 0; end // Reset (shows 0)
			 S1: begin alu_op = 8'b00000101; muxA = 5'b00001; muxB = 5'b00000; regs_en = 16'b0000000000000010; imm = 16'b0000000000000001; buff_en = 1; imm_control = 1;end // add 1(Imm) to R0. R1 = R0 + 1
			 S2: begin alu_op = 8'b00000101; muxA = 5'b00001; muxB = 5'b00010; regs_en = 16'b0000000000000100; imm = 0; buff_en = 1; imm_control = 0;end // R1+R0 = R2
			 S3: begin alu_op = 8'b00000101; muxA = 5'b00010; muxB = 5'b00011; regs_en = 16'b0000000000001000; imm = 0; buff_en = 1; imm_control = 0;end // R2+R1 = R3
			 S4: begin alu_op = 8'b00000101; muxA = 5'b00011; muxB = 5'b00100; regs_en = 16'b0000000000010000; imm = 0; buff_en = 1; imm_control = 0;end // R3+R2 = R4
			 S5: begin alu_op = 8'b00000101; muxA = 5'b00100; muxB = 5'b00101; regs_en = 16'b0000000000100000; imm = 0; buff_en = 1; imm_control = 0;end // R4+R3 = R5
			default: begin alu_op = 8'hxx; muxA = 5'bxxxxx; muxB = 5'bxxxxx; regs_en = 16'bxxxxxxxxxxxxxxxx; imm = 16'bxxxxxxxxxxxxxxxx; buff_en = 1'bx; imm_control = 1'bx; end
		endcase	
	end
endmodule
