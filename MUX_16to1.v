module MUX_16to1(reg_select, out, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15);
input [4:0] reg_select;
input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
output reg [15:0] out;

always@(reg_select, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15) begin
case(reg_select)
	5'b00000: out = 16'b0;
	5'b00001: out = r0;
	5'b00010: out = r1;
	5'b00011: out = r2;
	5'b00100: out = r3;
	5'b00101: out = r4;
	5'b00110: out = r5;
	5'b00111: out = r6;
	5'b01000: out = r7;
	5'b01001: out = r8;
	5'b01010: out = r9;
	5'b01011: out = r10;
	5'b01100: out = r11;
	5'b01101: out = r12;
	5'b01110: out = r13;
	5'b01111: out = r14;
	5'b10000: out = r15;
	default: out = 16'bx;
	endcase
	
end

endmodule 

//input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
//output wire [15:0] mux_output;
//wire  [15:0] output1, output2, output3, output4;
//// first layer
//MUX_4to1 mux_1(.select(reg_select[1:0]), .out(output1), .data_in1(r0), .data_in2(r1), .data_in3(r2), .data_in4(r3));
//MUX_4to1 mux_2(.select(reg_select[1:0]), .out(output2), .data_in1(r4), .data_in2(r5), .data_in3(r6), .data_in4(r7));
//MUX_4to1 mux_3(.select(reg_select[1:0]), .out(output3), .data_in1(r8), .data_in2(r9), .data_in3(r10), .data_in4(r11));
//MUX_4to1 mux_4(.select(reg_select[1:0]), .out(output4), .data_in1(r12), .data_in2(r13), .data_in3(r14), .data_in4(r15));
//
//// last layer
//MUX_4to1 mux_5 (.select(reg_select[3:2]), .out(mux_output), .data_in1(output1), .data_in2(output2), .data_in3(output3), .data_in4(output4));

