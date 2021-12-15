module nes_input (
	input	[7:0] control_in,
	output reg [15:0] control_out
);

	always @ (control_in)
		begin
			control_out = {8'b0, control_in};
		end

endmodule 