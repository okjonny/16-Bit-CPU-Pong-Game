module FSM_ALU(clk, reset, seven_seg1, seven_seg2, seven_seg3, seven_seg4, flag_reg);
input clk, reset; 
wire [7:0] ALU_Op;
wire [7:0] mux_control;
wire [15:0] reg_enables, imm, ALU_Bus, A_in, B_in; 
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire cin = 0;
wire Imm_mux_input = 0;
wire tri_buff_on = 1; 
output [6:0] seven_seg1, seven_seg2, seven_seg3, seven_seg4;

//wire [15:0] A_in, B_in; 
wire flag_en = 1; 
output [4:0] flag_reg;
//0 from register 
// otherwise get from immediate 
//module Fib_Fsm(clk, reset, alu_op, muxes, regs_en, imm);

Fib_Fsm fsm(
                .clk(clk),
                .reset(reset),
                .alu_op(ALU_Op),
                .muxes(mux_control),
                .regs_en(reg_enables),
                .imm(imm));
            
//module ALU(A, B, Op, Flags, cin, Output);
//ALU alu(
//          .A(A_in)
//          .B(B_in), 
//          .Op(ALU_Op),
//          .Flags(flag_reg),
//          .cin(cin),
//          .);

ALU_Reg alu_register(
                            .A_Mux_input(A_in),
                            .B_Mux_input(B_in),
                            .clk(clk), // ? 
                            .cin(cin),
                            .Imm_mux_input(Imm_mux_input), // ? 
                            .Immediate(imm),
                            .Reset(reset),
                            .Reg_Enable(reg_enables), 
                            .Tri_Enable(tri_buff_on), // ?
                            .OP(ALU_Op), 
                            .Flags_Enable(flag_en), 
                            .Flag_Reg_Output(flag_reg),
									 .ALU_Out_Bus(ALU_Bus));
									 
hexTo7Seg seg1(ALU_Bus[3:0], seven_seg1);
hexTo7Seg seg2(ALU_Bus[7:4], seven_seg2);
hexTo7Seg seg3(ALU_Bus[11:8], seven_seg3);
hexTo7Seg seg4(ALU_Bus[15:12], seven_seg4);
	 
endmodule 
