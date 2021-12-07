module nes_input (
	input	[7:0] control_in,
	output reg [15:0] control_out,
	output reg [15:0] nes_input_addr,
	output reg write_enable
);

	always @ (control_in)
		begin
			control_out = {8'b0, control_in};
			nes_input_addr = 16'b1111101000;
			write_enable = 1;
		end

endmodule 