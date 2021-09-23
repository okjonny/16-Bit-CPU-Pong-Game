module Five_Bit_Register(D_in, wEnable, reset, clk, r
    );
	 input [4:0] D_in;
	 input clk, wEnable, reset;
	 output reg [4:0] r;
	 
 always @( posedge clk )
	begin
	if (reset) r <= 5'b00000;
	else
		begin			
			if (wEnable)
				begin
					r <= D_in;
				end
			else
				begin
					r <= r;
				end
		end
	end
endmodule