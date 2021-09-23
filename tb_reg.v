`timescale 1ns / 1ps

module tb_reg;

//Inputs
reg[3:0] R;
reg L, Clock; 
 
//Outputs
 wire[3:0] Q;
 wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;
Regbank uut(
    .R(R),
     .L(L),
    .Clock(Clock),
    .Q(Q)
);

initial begin 

// initialize clock/reset
Clock = 0;
#2


R = 5;
L = 1;
#5
$display("R:%d L:%d Q:%d", R, L, Q);
#5;

R = 6;
L = 0;
#5
$display("R:%d L:%d Q:%d", R, L, Q);
#5;


end


always #5 Clock = ~Clock; 


endmodule