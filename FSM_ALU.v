module FSM_ALU(clk, reset, flag_reg, Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4);
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
wire [15:0] ALU_output;
output [6:0] Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4;

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

hexTo7Seg first(.x(ALU_output[15:12]),.z(Hex_output_4));
hexTo7Seg second(.x(ALU_output[11:8]),.z(Hex_output_3));
hexTo7Seg third(.x(ALU_output[7:4]),.z(Hex_output_2));
hexTo7Seg fourth(.x(ALU_output[3:0]),.z(Hex_output_1));
	 
endmodule 
