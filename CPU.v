module CPU(clk, reset);

// Reg bank

// FSM

// A Mux 

// B Mux

// 2:1 Mux 

// ALU
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

//B Ram

// B Ram tri-buff

// ALU tri-buff

endmodule 