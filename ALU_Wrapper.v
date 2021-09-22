module ALU_Wrapper(cin_button, A_button, B_button, Op_button, data_in, Flags, Hex_output_1, Hex_output_2, Hex_output_3, Hex_output_4);
input A_button, B_button;
input Op_button; 
input cin_button; 
input [9:0]data_in; 

reg [15:0] A,B;
reg [7:0] Op; 
wire cin;
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


always@(A_button)begin

		if(A_button == 0)begin
		A = data_in[9:0];
		end
end

always@(B_button)begin

		if(B_button == 0)begin
		B = data_in[9:0];
		end
end

always@(Op_button)begin

		if(Op_button == 0)begin
		Op = data_in[7:0];
		end
end

assign cin = ~cin_button;
//always@(cin_button)begin
//		if(cin_button == 1)
//			cin = 0;
//		else 
//			cin = 1;	
//end

hexTo7Seg first(.x(ALU_output[15:12]),.z(Hex_output_4));
hexTo7Seg second(.x(ALU_output[11:8]),.z(Hex_output_3));
hexTo7Seg third(.x(ALU_output[7:4]),.z(Hex_output_2));
hexTo7Seg fourth(.x(ALU_output[3:0]),.z(Hex_output_1));


endmodule