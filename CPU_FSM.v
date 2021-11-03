module CPU_FSM
(
	input clk, reset, is_d_type,
	output reg PC_enable, IR_enable, R_enable, ALU_Bus_enable, reg_read
);

	reg [3:0] state; 
	reg [3:0] nextState;
	
	parameter [3:0] S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011;
		
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
					if(is_d_type)
						nextState <= S3;
					else
						nextState <= S2;
				S2: nextState <= S0;
				S3: nextState <= S0;
			default: nextState <= S0;
			endcase
			end
		end
		
	always @(state)
	begin
		case (state)
			 S0: begin PC_enable = 0; R_enable = 0; IR_enable = 1; ALU_Bus_enable = 1; reg_read = 0; end //Fetch   alu will write back to reg and not bram
			 S1: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; end //Decode  alu will write back to reg and not bram
			 S2: begin PC_enable = 1; R_enable = 1; IR_enable = 0; ALU_Bus_enable = 1; reg_read = 0; end //Execute/Write-Back alu will write back to reg and not bram
			 S3: begin PC_enable = 1; R_enable = 1; IR_enable = 0; ALU_Bus_enable = 0; reg_read = 1; end //D-Type
		endcase
	end
endmodule
