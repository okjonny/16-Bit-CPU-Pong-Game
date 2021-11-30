module CPU_Wrapper(clk, reset, flags, Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4);
input clk, reset;
output [4:0] flags;
wire [15:0] ALU_output; 
output [6:0] Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4; 


CPU uut(.clk(clk), .reset(reset), .Flag_Reg_Output(flags), .ALU_Out_Bus(ALU_output));


hexTo7Seg first(.x(ALU_output[15:12]),.z(Hex_output_4));
hexTo7Seg second(.x(ALU_output[11:8]),.z(Hex_output_3));
hexTo7Seg third(.x(ALU_output[7:4]),.z(Hex_output_2));
hexTo7Seg fourth(.x(ALU_output[3:0]),.z(Hex_output_1));


endmodule 