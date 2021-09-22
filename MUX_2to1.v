module MUX_2to1(input wire [15:0] data_inA, input wire [15:0] data_inB, input wire control, output wire [15:0] out);

assign out = control ? data_inA : data_inB;
//if(control)
//	begin 
//	assign out = data_inA;
//	end
//else begin 
//	assign out = data_inB;
//	end
	
endmodule 