module tb_program_counter();

    reg pc_enable, clk, reset;
    wire [15:0] pc_out;
    integer i;


    program_counter dut(
        .clk(clk),
        .reset(reset), 
        .pc_enable(pc_enable),
        .pc_out(pc_out)
    );

	 

    always #5 clk = ~clk; 
	 
	 
	
    initial begin
        reset = 0;
        pc_enable = 0;
        clk = 0;
        #10;

        if(pc_out != 0)
            $stop;

        reset = 1;
        pc_enable = 1;

        #5;

        for(i = 1; i < 10; i = i + 1) begin
            #10;
            if(pc_out != i)
                $stop;
        end
        pc_enable = 0;
    end

endmodule