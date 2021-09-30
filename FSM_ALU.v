module FSM_ALU(clk, reset, flag_reg, ALU_output);
input clk, reset; 
wire [7:0] ALU_Op;
wire [4:0] mux_controlA;
wire [4:0] mux_controlB;
wire [15:0] reg_enables, imm; 
wire cin = 0;
wire Imm_mux_input;
wire buff_en;
wire [4:0] enable_4_reg; 
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
                .muxA(mux_controlA),
					 .muxB(mux_controlB),
                .regs_en(reg_enables),
                .imm(imm),
					 .buff_en(buff_en),
					 .imm_control(Imm_mux_input));

Encoder_16to4 encoder(.Encoder_In(reg_enables), .Encoder_Out(enable_4_reg));					 
ALU_Reg alu_register(
                .A_Mux_input(mux_controlA),
                .B_Mux_input(mux_controlB),
                .clk(clk),
                .cin(cin),
                .Imm_mux_input(Imm_mux_input), 
                .Immediate(imm),
                .Reset(reset),
                .Reg_Enable(enable_4_reg), 
                .Tri_Enable(buff_en),
                .OP(ALU_Op), 
                .Flags_Enable(flag_en), 
                .Flag_Reg_Output(flag_reg),
				    .ALU_Out_Bus(ALU_output));
	 
endmodule 
