module MUX_16to1(reg_select, mux_output, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15);
input [3:0] reg_select;
input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
output wire [15:0] mux_output;
wire  [15:0] output1, output2, output3, output4;
// first layer
MUX_4to1 mux_1(.select(reg_select[1:0]), .out(output1), .data_in1(r0), .data_in2(r1), .data_in3(r2), .data_in4(r3));
MUX_4to1 mux_2(.select(reg_select[1:0]), .out(output2), .data_in1(r4), .data_in2(r5), .data_in3(r6), .data_in4(r7));
MUX_4to1 mux_3(.select(reg_select[1:0]), .out(output3), .data_in1(r8), .data_in2(r9), .data_in3(r10), .data_in4(r11));
MUX_4to1 mux_4(.select(reg_select[1:0]), .out(output4), .data_in1(r12), .data_in2(r13), .data_in3(r14), .data_in4(r15));

// last layer
MUX_4to1 mux_5 (.select(reg_select[3:2]), .out(mux_output), .data_in1(output1), .data_in2(output2), .data_in3(output3), .data_in4(output4));

endmodule 