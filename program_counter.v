module program_counter(clk, reset, pc_enable, pc_out);
    input pc_enable;
    input clk, reset;
    output reg [15:0] pc_out;

    initial begin
    pc_out = 16'b0000000000000000;
    end

    always @ (posedge clk, negedge reset)
    begin
        if (~reset)
            pc_out <= 0;                // initial state
//  else if (branch_inst) // Extra input port "branch_insts"
//    pc <= pc + immediate; // immediate in 2's complement, signed form
    else if(pc_enable)
    pc_out <= pc_out + 16'b0000000000000001;     // increment counter + 1
end
endmodule