module CPU_FSM
(
	input clk, reset,
	output reg PC_enable, IR_enable, R_enable, ALU_Bus_enable
);

	reg [3:0] state; 
	reg [3:0] nextState;
	
	parameter [3:0] S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010;
		
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
				S1: nextState <= S2;
				S2: nextState <= S0;
			default: nextState <= S0;
			endcase
			end
		end
		
	always @(state)
	begin
		case (state)
			 S0: begin PC_enable = 0; R_enable = 0; IR_enable = 1; ALU_Bus_enable = 1; end //Fetch   alu will write back to reg and not bram
			 S1: begin PC_enable = 0; R_enable = 0; IR_enable = 0; ALU_Bus_enable = 1; end //Decode  alu will write back to reg and not bram
			 S2: begin PC_enable = 1; R_enable = 1; IR_enable = 0; ALU_Bus_enable = 1; end //Execute/Write-Back alu will write back to reg and not bram
		endcase
	end
endmodule
