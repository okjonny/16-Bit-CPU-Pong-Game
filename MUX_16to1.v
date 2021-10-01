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