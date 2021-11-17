module pc_increment(clk, reset, pc_in, pc_out, pc_enable);
    input pc_enable;
    input clk, reset;
	 input [15:0] pc_in;
    output reg [15:0] pc_out;

    initial begin
    pc_out = 16'b0000000000000000;
    end

    always @ (posedge clk, negedge reset)
    begin
        if (~reset)
            pc_out <= 0;                // initial state
    if(pc_enable)
		pc_out <= pc_out + 16'b0000000000000001;     // increment counter + 1
end
endmodule 