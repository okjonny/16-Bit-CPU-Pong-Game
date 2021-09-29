module ALU_Reg (A_Mux_input, B_Mux_input, clk, cin, Imm_mux_input, Immediate,Reset, Reg_Enable,Tri_Enable, OP, Flags_Enable, Flag_Reg_Output, ALU_Out_Bus);
input [3:0] A_Mux_input, B_Mux_input, Reg_Enable;
wire [4:0] Flags;
input clk, Imm_mux_input, Reset;
input [15:0] Immediate;
input Tri_Enable, Flags_Enable, cin;
input [7:0] OP;
wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
wire [15:0] A_mux, B_mux, ALU_Bus, Imm_out;
wire [15:0] Reg_Enable_16;
output [4:0] Flag_Reg_Output;
output wire [15:0] ALU_Out_Bus;
	 
//ALU_Output
Decoder_4to16 Decode_Reg_Enable(.Decode_In(Reg_Enable), .Decode_Out(Reg_Enable_16));	 
	 
RegBank Bank(.ALUBus(ALU_Bus),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15),.regEnable(Reg_Enable_16),.clk(clk),.reset(Reset));

MUX_16to1 A(.reg_select(A_Mux_input),.mux_output(A_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));
MUX_16to1 B(.reg_select(B_Mux_input),.mux_output(B_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

MUX_2to1 Imm_mux(.data_inA(B_mux), .data_inB(Immediate), .control(Imm_mux_input),.out(Imm_out)); 
tri_buf ALU_buf(.enable(Tri_Enable), .D(ALU_Out_Bus),.Q(ALU_Bus));

ALU main(.A(A_mux),.B(Imm_out),.Op(OP),.Flags(Flags),.cin(cin), .Output(ALU_Out_Bus));

Five_Bit_Register Flag_reg(.D_in(Flags), .wEnable(Flags_Enable), .reset(Reset), .clk(clk), .r(Flag_Reg_Output));

endmodule 