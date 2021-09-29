module tri_buf (enable, D, Q);

input enable;

input [15:0] D;

output wire [15:0] Q;

assign Q = enable ? D: 16'bx;

endmodule 