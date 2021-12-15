module MUX_2to1(input wire [15:0] data_inA, input wire [15:0] data_inB, input wire control, output reg [15:0] out);

always@(*) begin

out = control ? data_inB : data_inA;
			// Data B goes it true.   // Data A goes if false.

end
endmodule 