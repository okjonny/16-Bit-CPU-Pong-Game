module CPU(clk, reset, Flag_Reg_Output, ALU_Out_Bus);

wire [4:0] A_Mux_input, B_Mux_input;
wire[4:0] Reg_Enable;
wire [4:0] Flags;
input clk,reset;
wire [15:0] Immediate;
wire Tri_Enable, Flags_Enable, cin;
wire [7:0] OP, muxes;
wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
wire [15:0] A_mux, B_mux, ALU_Bus, Imm_out;
wire [15:0] regs_en, imm; 
wire [15:0] Reg_Enable_16;
output [4:0] Flag_Reg_Output;
output wire [15:0] ALU_Out_Bus;
//FSM


// Reads in a 4 bit reg_enable and turns it to 16 bit reg_enable.
Decoder_4to16 Decode_Reg_Enable(.Decode_In(Reg_Enable), .Decode_Out(Reg_Enable_16));	 

// Stores all the registers and connects them to the ALU_Bus. 	 
RegBank Bank(.ALUBus(ALU_Bus),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15),.regEnable(Reg_Enable_16),.clk(clk),.reset(Reset));

// This mux takes in from the register bank.
MUX_16to1 A(.reg_select(A_Mux_input),.out(A_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

// This mux takes in from the register bank.
MUX_16to1 B(.reg_select(B_Mux_input),.out(B_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

// This selects either the register value input or the immediate value.
MUX_2to1 Imm_mux(.data_inA(B_mux), .data_inB(Immediate), .control(Imm_mux_input),.out(Imm_out)); 

// ALU does opcode instructions.
ALU main(.A(A_mux),.B(Imm_out),.Op(OP),.Flags(Flags),.cin(cin), .Output(ALU_Out_Bus));

// Stores the flags.
Five_Bit_Register Flag_reg(.D_in(Flags), .wEnable(Flags_Enable), .reset(Reset), .clk(clk), .r(Flag_Reg_Output));

// Allows the bus to write to the registers.
tri_buf ALU_buf(.enable(Tri_Enable), .D(ALU_Out_Bus),.Q(ALU_Bus));

// Allows the Bram to write to the registers.

//tri_buf B_Ram(.enable(), .D(ALU_Out_Bus), .Q(ALU_Bus));

//B Ram
bram storage(.data_a(data_a), .data_b(data_b), .addr_a(addr_a), .addr_b(addr_b), .we_a(we_a), .we_b(we_b), .clk(clk), .q_a(q_a), .q_b(q_b));


endmodule 