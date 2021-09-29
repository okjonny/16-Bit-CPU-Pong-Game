module FSM_ALU(clk, reset, flag_reg, ALU_output);
input clk, reset; 
wire [7:0] ALU_Op;
wire [7:0] mux_control;
wire [15:0] reg_enables, imm, A_in, B_in; 
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire cin = 0;
wire Imm_mux_input = 0;
wire tri_buff_on = 1;
 
wire [3:0] enable_4_reg;
//wire [15:0] A_in, B_in; 
wire flag_en = 1; 
output [4:0] flag_reg;
output [15:0] ALU_output;

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

Encoder_16to4 encoder(.Encoder_In(reg_enables), .Encoder_Out(enable_4_reg));					 
ALU_Reg alu_register(
                            .A_Mux_input(mux_control[7:4]),
                            .B_Mux_input(mux_control[3:0]),
                            .clk(clk),
                            .cin(cin),
                            .Imm_mux_input(Imm_mux_input), 
                            .Immediate(imm),
                            .Reset(reset),
                            .Reg_Enable(enable_4_reg), 
                            .Tri_Enable(tri_buff_on),
                            .OP(ALU_Op), 
                            .Flags_Enable(flag_en), 
                            .Flag_Reg_Output(flag_reg),
									 .ALU_Out_Bus(ALU_output));
	 
endmodule 
