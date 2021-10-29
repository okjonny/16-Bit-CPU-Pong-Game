module CPU(clk, reset, Flag_Reg_Output, ALU_Out_Bus);

wire [4:0] A_Mux_input, B_Mux_input;
wire[4:0] Reg_Enable;
wire [4:0] Flags;
input clk,reset;
wire [15:0] Immediate, instr_out;
wire ALU_Bus_enable, Flags_Enable, cin, PC_enable, IR_enable, r_i_switch, R_enable;
wire [7:0] OP, muxes;
wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
wire [15:0] A_mux, B_mux, ALU_Bus, Imm_out;
wire [15:0] regs_en, imm;
wire [15:0] Reg_Enable_16;
output [4:0] Flag_Reg_Output;
output wire [15:0] ALU_Out_Bus;

//Decoder
decoder Dec(.instruction_in(instr_out), .instruction_out(OP), .R_dest(B_Mux_input), .R_src(A_Mux_input), .immediate(Immediate), .c_in(cin), .RI_out(r_i_switch));

//FSM
CPU_FSM FSM(.clk(clk), .reset(reset), .PC_enable(PC_enable), .IR_enable(IR_enable), .R_enable(R_enable));

//Program counter
program_counter PC(.clk(clk), .reset(reset), .pc_enable(PC_enable), .pc_out(addr_a));

//Instruction Register
instruction_reg Instruction_Register(.d_enable(IR_enable), .clk(clk), .instr_in(q_a), .instr_out(instr_out));

// Reads in a 4 bit reg_enable and turns it to 16 bit reg_enable.
Decoder_4to16 Decode_Reg_Enable(.Decode_In(B_Mux_input), .Decode_Out(Reg_Enable_16));	 

// Stores all the registers and connects them to the ALU_Bus. 	 
RegBank Bank(.ALUBus(ALU_Bus),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15),.regEnable(Reg_Enable_16),.clk(clk),.reset(Reset));

// This mux takes in from the register bank.
MUX_16to1 A(.reg_select(A_Mux_input),.out(A_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

// This mux takes in from the register bank.
MUX_16to1 B(.reg_select(B_Mux_input),.out(B_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

// This selects either the register value input or the immediate value.
MUX_2to1 Imm_mux(.data_inA(B_mux), .data_inB(Immediate), .control(r_i_switch),.out(Imm_out)); 

// ALU does opcode instructions.
ALU main(.A(A_mux),.B(Imm_out),.Op(OP),.Flags(Flags),.cin(cin), .Output(ALU_Out_Bus));

// Stores the flags.
Five_Bit_Register Flag_reg(.D_in(Flags), .wEnable(Flags_Enable), .reset(Reset), .clk(clk), .r(Flag_Reg_Output));

// Allows the bus to write to the registers.
//tri_buf ALU_buf(.enable(Tri_Enable_ALU), .D(ALU_Out_Bus),.Q(ALU_Bus));

// Allows the Bram to write to the registers.

//We are reading from BRAM's A output, B is reserved for peripherals
//tri_buf B_Ram(.enable(Tri_Enable_BRAM), .D(q_a), .Q(ALU_Bus));


//If control == 1, ALU Bus is enabled, else BRAM
MUX_2to1 ALU_Bus_MUX(.data_inA(q_a), .data_inB(ALU_Out_Bus), .control(ALU_Bus_enable), .out(ALU_Bus));

//B Ram
bram storage(.data_a(data_a), .data_b(data_b), .addr_a(addr_a), .addr_b(addr_b), .we_a(we_a), .we_b(we_b), .clk(clk), .q_a(q_a), .q_b(q_b));


endmodule 