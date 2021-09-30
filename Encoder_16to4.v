module Encoder_16to4(Encoder_In, Encoder_Out);

input [15:0] Encoder_In;
output reg [3:0] Encoder_Out;


always @ (Encoder_In)
begin 
	Encoder_Out = 0;
	if(Encoder_In == 16'h0002)
	begin 
	Encoder_Out = 1;
	end
	if(Encoder_In == 16'h0004)
	begin 
	Encoder_Out = 2;
	end
	if(Encoder_In == 16'h0008)
	begin 
	Encoder_Out = 3;
	end
	if(Encoder_In == 16'h0010)
	begin 
	Encoder_Out = 4;
	end
	if(Encoder_In == 16'h0020)
	begin 
	Encoder_Out = 5;
	end
	if(Encoder_In == 16'h0040)
	begin 
	Encoder_Out = 6;
	end
	if(Encoder_In == 16'h0080)
	begin 
	Encoder_Out = 7;
	end
	if(Encoder_In == 16'h0100)
	begin 
	Encoder_Out = 8; 
	end
	if(Encoder_In == 16'h0200)
	begin 
	Encoder_Out = 9;
	end
	if(Encoder_In == 16'h0400)
	begin 
	Encoder_Out = 10;
	end
	if(Encoder_In == 16'h0800)
	begin 
	Encoder_Out = 11;
	end
	if(Encoder_In == 16'h1000)
	begin 
	Encoder_Out = 12;
	end
	if(Encoder_In == 16'h2000)
	begin 
	Encoder_Out = 13;
	end
	if(Encoder_In == 16'h4000)
	begin 
	Encoder_Out = 14;
	end
	if(Encoder_In == 16'h8000)
	begin 
	Encoder_Out = 15;
	end

end
endmodule
