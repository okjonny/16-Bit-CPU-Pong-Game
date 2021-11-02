module Decoder_4to16(Decode_In, Decode_Out, write_enable);

input wire write_enable;
input [4:0]   Decode_In;
output reg [15:0] Decode_Out;

   parameter mask = 16'b0000_0000_0000_0001;
	
always @(write_enable, Decode_In)
	begin
	if(write_enable)
		Decode_Out = mask << (Decode_In - 1);
	else
		Decode_Out = 16'b0;
	end
endmodule 