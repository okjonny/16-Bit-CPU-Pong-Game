module CPU_Wrapper(clk, reset, flags, GIO_pins, Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4,Hex_output_5,Hex_output_6, red, green, blue, hsync, vsync, blankN ,vgaClk);
input clk, reset;
input [7:0] GIO_pins;
output [4:0] flags;
wire [15:0] ALU_output, r15_output, mem_output, r2_output; 
output [6:0] Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4, Hex_output_5, Hex_output_6;
// Hex_output_7, Hex_output_8;
reg mem_addy = 16'b0; 
output  [7:0] red, green, blue; 
output hsync, vsync;
output  blankN; 
output wire vgaClk;


CPU uut(.clk(clk), 
          .reset(reset),
          .Flag_Reg_Output(flags),
          .ALU_Out_Bus(ALU_output),
          .GIO_pins(GIO_pins),
          .addr_b(mem_addy),
          .q_b(mem_output),
          .r15(r15_output),
          .r2(r2_output));

vga_control Display(
     .clk(clk), 
     .mem_in(r2_output),
    .red(red),
     .green(green),
     .blue(blue),
    .hsync(hsync),
     .vsync(vsync),
    .blankN(blankN), 
     .vgaClk(vgaClk)
);

hexTo7Seg first(.x(r2_output[15:12]),.z(Hex_output_4));
hexTo7Seg second(.x(r2_output[11:8]),.z(Hex_output_3));
hexTo7Seg third(.x(r2_output[7:4]),.z(Hex_output_2));
hexTo7Seg fourth(.x(r2_output[3:0]),.z(Hex_output_1));

hexTo7Seg fith(.x(r15_output[3:0]),.z(Hex_output_5));
hexTo7Seg sixth(.x(r15_output[7:4]),.z(Hex_output_6));
//hexTo7Seg seventh(.x(r15_output[7:4]),.z(Hex_output_7));
//hexTo7Seg eigth(.x(r15_output[3:0]),.z(Hex_output_8));

endmodule