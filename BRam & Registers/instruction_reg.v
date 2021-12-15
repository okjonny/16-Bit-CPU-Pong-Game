module instruction_reg(d_enable, clk, instr_in, instr_out);
input d_enable, clk;
input [15:0] instr_in;
output reg [15:0] instr_out;

    always @ (negedge clk)
        if (d_enable) 
        begin
            instr_out <= instr_in;
        end
endmodule 