module pc_displace(pc_in, op, flags, imm_in, dis_out);
     input [15:0] pc_in;
    input [7:0]  op;
     input [4:0]  flags;
     input [15:0] imm_in;
     
     output reg [15:0] dis_out;
     
     
     parameter type;
     parameter [3:0] condition;
     
     // Flags[0] - Carry-bit
    // Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
    // Flags[2] - Flag: F bit to signal arithmetic overflow
    // Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
    // Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
     
     
     //1100 -> branch (type = 1)  1000-> jump (type = 0)
     if(op[7:4] == 1100) begin
        type = 1;
     end
     else begin
        type = 0;
     end
     
     //last 4 bits of op
     condition = op[3:0];
     
     
     always@(imm_in, pc_in) begin
            //checks if jump
            if(type == 0) begin
                case(condition) 
                    //EQ
                    4'b0000: begin
                                //check zero flag
                                if(flags[3] == 1) begin
                                    dis_out = imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                                end
                    //NE            
                    4'b0001: begin
                                //check zero flag
                                if(flags[3] == 0) begin
                                    dis_out = imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                    
                                end
                    //GT        
                    4'b0110: begin
                                if((flags[3] == 1) || (flags[4] == 1)) begin
                                    dis_out = imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                                end
                    //LE    
                    4'b0111: begin
                                if(flags[4] == 0) begin
                                    dis_out = imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                                end
                                
                
                endcase
            end
            
            //if branch
            if(type == 1) begin
                case(condition)
                            //EQ
                    4'b0000: begin
                                if(flags[3] == 1) begin
                                    dis_out = pc_in + imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                                end
                    //NE            
                    4'b0001: begin
                                if(flags[3] == 0) begin
                                    dis_out = pc_in + imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                    
                                end
                    //GT        
                    4'b0110: begin
                                if((flags[3] == 1) || (flags[4] == 1)) begin
                                    dis_out = pc_in + imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                                end
                    //LE    
                    4'b0111: begin
                                if(flags[4] == 0) begin
                                    dis_out = pc_in + imm_in;
                                end
                                else begin
                                    dis_out = pc_in + 1;
                                end
                                end
                                
                endcase
            end
            end