module tri_buf (enable, D, Q);

input enable;

input [15:0] D;

output reg [15:0] Q;

always@(*) begin

Q = enable ? D: 16'bx;

end

endmodule 