module program_counter(clk, reset, pc_in, pc_enable, pc_out);
    input clk, reset, pc_enable;
	 input [15:0] pc_in;
    output reg [15:0] pc_out;

    initial begin
    pc_out = 16'b0000000000000000;
    end

    always @ (posedge clk, negedge reset)
    begin
    if (~reset)
      pc_out <= 0;                // initial state
    else if(pc_enable)
		pc_out <= pc_in;     // increment counter + 1
	 else
		pc_out <= pc_out;
end
endmodule 