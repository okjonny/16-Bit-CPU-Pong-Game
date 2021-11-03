module MUX_16to1(reg_select, out, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15);
input [3:0] reg_select;
input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
output reg [15:0] out;

always@(reg_select, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15) begin
case(reg_select)
	4'b0000: out = r0;
	4'b0001: out = r1;
	4'b0010: out = r2;
	4'b0011: out = r3;
	4'b0100: out = r4;
	4'b0101: out = r5;
	4'b0110: out = r6;
	4'b0111: out = r7;
	4'b1000: out = r8;
	4'b1001: out = r9;
	4'b1010: out = r10;
	4'b1011: out = r11;
	4'b1100: out = r12;
	4'b1101: out = r13;
	4'b1110: out = r14;
	4'b1111: out = r15;
	default: out = 16'bx;
	endcase
	
end

endmodule 