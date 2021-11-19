module CPU(clk, reset, Flag_Reg_Output, ALU_Out_Bus); 
wire [2:0] instr_type;
wire [3:0] A_Mux_input, B_Mux_input;
wire[3:0] Reg_Enable, cond_type;
wire [4:0] Flags;
input clk,reset;
wire [15:0] Immediate, instr_out, data_a, data_b, addr_a, addr_b, q_a, q_b, pc_out, load_store_wire, memory_link_wire, link;
wire ALU_Bus_enable, Flags_Enable, cin, PC_enable, PC_jump_enable, IR_enable, r_i_switch, R_enable, we_a, we_b, ALU_Bus_control, reg_read, WrtBrm_en, is_load, memory_link_control;
wire [7:0] OP, muxes;
wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
wire [15:0] A_mux, B_mux, ALU_Bus, Imm_out;
wire [15:0] regs_en, imm, displacement;
wire [15:0] Reg_Enable_16;
output [4:0] Flag_Reg_Output;
output wire [15:0] ALU_Out_Bus;

//FSM
CPU_FSM FSM(.clk(clk), .reset(reset), .PC_enable(PC_enable), .IR_enable(IR_enable), .R_enable(R_enable) , .ALU_Bus_enable(ALU_Bus_control), .instr_type(instr_type), .reg_read(reg_read), .WrtBrm_en(WrtBrm_en), .Flags_Enable(Flags_Enable), .link_en(memory_link_control));

// Program Counter Displace
pc_displace PC_displacer(.pc_in(pc_out), .op(OP), .flags(Flag_Reg_Output), .imm_in(A_mux), .link_out(link), .dis_out(displacement), .condition(Immediate));

//MUX that switches between A mux for reg (load) and B mux for Reg (store)
MUX_2to1 Load_Store_MUX(.data_inA(B_mux), .data_inB(A_mux), .control(is_load),.out(load_store_wire)); 

//MUX that switches between PC (R-type) and Reg (D-type)
MUX_2to1 PC_Reg_MUX(.data_inA(pc_out), .data_inB(load_store_wire), .control(reg_read),.out(addr_a)); 

//Program counter
program_counter PC(.clk(clk), .reset(reset),.pc_in(displacement),.pc_enable(PC_enable), .pc_out(pc_out));

//Instruction Register
instruction_reg Instruction_Register(.d_enable(IR_enable), .clk(clk), .instr_in(q_a), .instr_out(instr_out));

//Decoder
decoder Dec(.instruction_in(instr_out), .instruction_out(OP), .R_dest(B_Mux_input), .R_src(A_Mux_input), .immediate(Immediate), .RI_out(r_i_switch), .instr_type(instr_type), .cond_type(cond_type), .is_load(is_load));

// Reads in a 4 bit reg_enable and turns it to 16 bit reg_enable.
Decoder_4to16 Decode_Reg_Enable(.Decode_In(B_Mux_input), .Decode_Out(Reg_Enable_16), .write_enable(R_enable));	 

// Stores all the registers and connects them to the ALU_Bus. 	 
RegBank Bank(.ALUBus(ALU_Bus),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15),.regEnable(Reg_Enable_16),.clk(clk),.reset(reset));

// This mux takes in from the register bank.
MUX_16to1 A(.reg_select(A_Mux_input),.out(A_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

// This mux takes in from the register bank.
MUX_16to1 B(.reg_select(B_Mux_input),.out(B_mux), .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),.r15(r15));

// This selects either the register value input or the immediate value.
MUX_2to1 Imm_mux(.data_inA(B_mux), .data_inB(Immediate), .control(r_i_switch),.out(Imm_out)); 

// ALU does opcode instructions.
ALU main(.A(A_mux),.B(Imm_out),.Op(OP),.Flags(Flags), .Output(ALU_Out_Bus));

// Stores the flags.
Five_Bit_Register Flag_reg(.D_in(Flags), .wEnable(Flags_Enable), .reset(reset), .clk(clk), .r(Flag_Reg_Output));

//MUX to switch between BRAM and Rlink
MUX_2to1 PC_Link_MUX(.data_inA(q_a), .data_inB(link), .control(memory_link_control), .out(memory_link_wire));


//If control == 1, ALU Bus is enabled, else BRAM
MUX_2to1 ALU_Bus_MUX(.data_inA(memory_link_wire), .data_inB(ALU_Out_Bus), .control(ALU_Bus_control), .out(ALU_Bus));

//B Ram
bram storage(.data_a(A_mux), .data_b(data_b), .addr_a(addr_a), .addr_b(addr_b), .we_a(WrtBrm_en), .we_b(we_b), .clk(clk), .q_a(q_a), .q_b(q_b));


endmodule 