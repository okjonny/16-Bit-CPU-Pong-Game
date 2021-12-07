module CPU_Wrapper(clk, reset, flags, GIO_pins, Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4);
input clk, reset;
input [7:0] GIO_pins;
output [4:0] flags;
wire [15:0] ALU_output, bram_output; 
output [6:0] Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4; 


CPU uut(.clk(clk), .reset(reset), .Flag_Reg_Output(flags), .ALU_Out_Bus(ALU_output), .GIO_pins(GIO_pins), .q_b(bram_output));


hexTo7Seg first(.x(bram_output[15:12]),.z(Hex_output_4));
hexTo7Seg second(.x(bram_output[11:8]),.z(Hex_output_3));
hexTo7Seg third(.x(bram_output[7:4]),.z(Hex_output_2));
hexTo7Seg fourth(.x(bram_output[3:0]),.z(Hex_output_1));


endmodule 