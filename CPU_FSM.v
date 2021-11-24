module CPU_FSM
(
	input clk, reset,
	input [2:0] instr_type,
	output reg PC_enable, IR_enable, R_enable, ALU_Bus_enable, reg_read, WrtBrm_en, Flags_Enable, link_en
);

	reg [3:0] state; 
	reg [3:0] nextState;
	
	parameter [3:0] S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000, S9 = 4'b1001;
		
	always @(negedge clk) begin
		state <= nextState;
	end
	
	always @(posedge clk, negedge reset)begin
	//changed 
		if (!reset)
			nextState <= S0;
		else begin
			case(state)
				S0: nextState <= S1;
				S1: 
					//00 is R-Type, 01 is STORE, 10 is LOAD
					if(instr_type == 3'b000)
						nextState <= S2;
					else if(instr_type == 3'b001)
						nextState <= S3;
					else if(instr_type == 3'b010)
						nextState <= S4;
					else if (instr_type == 3'b011)
						nextState <= S7;
					else if (instr_type == 3'b100)
						nextState <= S8;
					else if (instr_type == 3'b101)
						nextState <= S9;
					else
					nextState <= S0;
				S2: nextState <= S0;
				S3: nextState <= S6; //
				S4: nextState <= S5;
				S5: nextState <= S0;
				S6: nextState <= S0;
				S7: nextState <= S0;
				S8: nextState <= S0;
				S9: nextState <= S0;
			default: nextState <= S0;
			endcase
			end
		end
		
		
		
	always @(state)
	begin
		case (state)
			 S0: begin PC_enable = 0; R_enable = 0; IR_enable = 1; ALU_Bus_enable = 1; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 0; link_en = 0; end //Fetch   alu will write back to reg and not bram
			 S1: begin PC_enable = instr_type != 3'b101; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 0; link_en = 1; end //Decode  alu will write back to reg and not bram
			 S2: begin PC_enable = 0; R_enable = 1; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 1; link_en = 0; end //Execute/Write-Back alu will write back to reg and not bram
			 S3: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 0; reg_read = 1; WrtBrm_en = 1; Flags_Enable = 0; link_en = 0; end //STORE
			 S4: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 0; reg_read = 1; WrtBrm_en = 0; Flags_Enable = 0; link_en = 0; end //LOAD
			 S5: begin PC_enable = 0; R_enable = 1; IR_enable = 0; ALU_Bus_enable = 0; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 0; link_en = 0; end //store data to regfile via ALU_mux
			 S6: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 0; link_en = 0; end // Give store one more clock cycle.
			 S7: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 0; link_en = 0; end // Jump
			 S8: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; WrtBrm_en = 0; Flags_Enable = 0; link_en = 0; end // Branch
			 S9: begin PC_enable = 0; R_enable = 1; IR_enable = 0; ALU_Bus_enable = 0; reg_read = 1; WrtBrm_en = 0; Flags_Enable = 0; link_en = 1; end // Jump and Load
		endcase
end
	
endmodule
