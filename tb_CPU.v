`timescale 1ns/1ps
module tb_CPU;
reg reset, clk;
wire [4:0] Flag_Reg_Output;
wire [15:0] ALU_Out_Bus;

CPU uut(.clk(clk), 
		  .reset(reset),
		  .Flag_Reg_Output(Flag_Reg_Output),
		  .ALU_Out_Bus(ALU_Out_Bus));

initial begin
		reset = 0; #20;
		reset = 1; #20;
		reset = 0; #20;
		
		clk = 0; #20;
		clk = 1; #20; // completes state zero
		clk = 0; #20;
		
		$display("ALU_Output: %d", ALU_Out_Bus);

		clk = 0; #20;
		clk = 1; #20; // completes state zero
		clk = 0; #20;
		
		$display("ALU_Output: %d", ALU_Out_Bus);
end
endmodule
