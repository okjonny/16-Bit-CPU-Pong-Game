module pc_mux_2to1(immediate, pc_mux_en, data_in, out);

input [15:0] immediate; // some immediate jump instruction / displacement
input pc_mux_en;       // eng
input [15:0] data_in;  // bram
output reg [15:0] out; // goes into pc




always @(pc_mux_en, immediate, data_in) begin // pc_mux_en, immediate, data_in
    // If control is present, Select the program counter + displacement
    if(pc_mux_en) begin
        out = immediate;
    end
    // Else, Select program counter +1
    else begin
        out = data_in + 16'b0000000000000001; 
    end


end
endmodule