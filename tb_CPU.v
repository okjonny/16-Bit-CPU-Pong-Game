`timescale 1ns/1ps
module tb_CPU;
reg reset, clk;
reg [7:0] GIO_pins;
wire [4:0] Flag_Reg_Output;
wire [15:0] ALU_Out_Bus, mem_output, r15_output,r8_output;
reg [15:0] mem_addy = 16'b0; 

CPU uut(.clk(clk), 
		  .reset(reset),
		  .Flag_Reg_Output(Flag_Reg_Output),
		  .ALU_Out_Bus(ALU_Out_Bus),
		  .GIO_pins(GIO_pins),
		  .addr_b(mem_addy), 
		  .q_b(mem_output), 
		  .r15(r15_output),
		  .r8(r8_output));

		  
		  
always #20 clk = ~clk; 

initial begin


		reset = 1; #20;
		reset = 0; #20;
		reset = 1; #20;
		
		clk = 0; #20;
		
		GIO_pins = 8'b10111111;

end
endmodule
