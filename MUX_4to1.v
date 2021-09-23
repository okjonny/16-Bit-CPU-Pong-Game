module MUX_4to1(select, out, data_in1, data_in2, data_in3, data_in4);
input wire [15:0] data_in1; // 01
input wire [15:0] data_in2; // 00
input wire [15:0] data_in3; // 11
input wire [15:0] data_in4; // 10
input wire [1:0] 	select;
output wire [15:0] out;

assign out = select[1] ? (select[0] ? data_in4 : data_in3 ) : (select[0] ? data_in2 : data_in1); 

endmodule
