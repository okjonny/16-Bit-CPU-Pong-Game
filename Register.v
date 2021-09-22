module Register(D_in, wEnable, reset, clk, r
    );
	 input [15:0] D_in;
	 input clk, wEnable, reset;
	 output reg [15:0] r;
	 
	 //reset == 0
 always @( posedge clk )
	begin
	if (reset) r <= 16'b0000000000000000;
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