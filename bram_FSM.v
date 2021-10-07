module bram_FSM
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input clk, reset,
	output reg [(DATA_WIDTH-1):0] data_a, data_b,
	output reg [(ADDR_WIDTH-1):0] addr_a, addr_b,
	output reg we_a, we_b
);

	reg [(DATA_WIDTH-1):0] q_a, q_b


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
			 S0: begin data_a = b'0000000000001000; data_b = b'0000000000001010; addr_a = 0; addr_b = 1; we_a = 1; we_b = 1	; end // Write (A = 8, B = 10)
			 S1: begin data_a = 0; data_b = 0; addr_a = 0; addr_b = 1; we_a = 0; we_b = 0	; end // Read (A = 8, B = 10)
			 S2: begin data_a = b'0000000000001001; data_b = b'0000000000001011; addr_a = 0; addr_b = 1; we_a = 1; we_b = 1	; end // Modify (A += 1, B += 1, so A= 9, B = 11)
			 S3: begin data_a = b'0000000000100000; data_b = b'0000000000010010; addr_a = 510; addr_b = 511; we_a = 1; we_b = 1	; end // Write (A=32, B=18)
			 S4: begin data_a = 0; data_b = 0; addr_a = 0; addr_b = 0; we_a = 0; we_b = 0	; end // Read (A=32, B=18)
			 S5: begin data_a = 0; data_b = 0; addr_a = 0; addr_b = 1; we_a = 0; we_b = 0	; end // Verify (Basically reading what we had stored in S2 to see it's unchanged, (A=9, B=11)
		endcase	
	end
endmodule
