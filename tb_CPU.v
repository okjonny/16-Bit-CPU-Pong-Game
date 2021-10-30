`timescale 1ns/1ps
module tb_CPU;
reg reset, clk;
wire [4:0] Flag_Reg_Output;
wire [15:0] ALU_Out_Bus;

CPU uut(.clk(clk), 
		  .reset(reset),
		  .Flag_Reg_Output(Flag_Reg_Output),
		  .ALU_Out_Bus(ALU_Out_Bus));

		  
		  
always #20 clk = ~clk; 

initial begin


		reset = 0; #20;
		reset = 1; #20;
		reset = 0; #20;
		
		clk = 0; #20;
end
endmodule
