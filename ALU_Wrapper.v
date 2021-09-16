module ALU_Wrapper(cin, A_button, B_button, Op_button, data_in, Flags, Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4);
input A_button, B_button;
input Op_button; 
input cin; 
input [9:0]data_in; 

reg [15:0] A,B;
reg [7:0] Op; 
output [4:0] Flags;
wire [15:0] ALU_output; 
output [6:0] Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4; 


 ALU uut(
    .A(A),
	 .B(B),  // ALU 8-bit Inputs                 
    .Op(Op),// ALU Selection
	 .Flags(Flags),
    .Output(ALU_output), // ALU 8-bit Output
	 .cin(cin)
);

hexTo7Seg first(.x(ALU_output[15:12]),.z(Hex_output_1));
hexTo7Seg second(.x(ALU_output[15:12]),.z(Hex_output_2));
hexTo7Seg third(.x(ALU_output[15:12]),.z(Hex_output_3));
hexTo7Seg fourth(.x(ALU_output[15:12]),.z(Hex_output_4));


endmodule