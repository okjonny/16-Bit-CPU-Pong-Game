module clkDivider(
        input refclk,
        input rst,
        output reg outclk_0);

always @ (posedge refclk) begin 
        if(rst) outclk_0 <= 0; 
        else begin 
        outclk_0 = ~(outclk_0);
            end 
        end 
endmodule 