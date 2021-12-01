module clock_divider (
    input wire clk,
    output reg div_clk = 0
);

integer counter = 0;

// For 25 Mhz => 50Mhz / (2*frequency_wanted) - 1
// 50Mhz / (2*25Mhz) - 1 = 0
parameter div_val = 0;

always @(posedge clk) begin
   if (counter == div_val) begin
        counter <= 0;
        div_clk <= ~div_clk;
    end
    else begin
      counter <= counter + 1; 
        div_clk <= ~div_clk;
    end
end
endmodule //clock_divider