module pc_displace(pc_in, op, flags, imm_in, dis_out, condition);
     input [15:0] pc_in;
     input [7:0]  op;
     input [4:0]  flags;
     input [15:0] imm_in;
	  input [15:0] condition;

     
     output reg [15:0] dis_out;
     
     
     reg type;
     
     // Flags[0] - Carry-bit
    // Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
    // Flags[2] - Flag: F bit to signal arithmetic overflow
    // Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
    // Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
     
     
  
     
     always@(imm_in, pc_in, op, condition, flags) begin
	  
	       //1100 -> branch (type = 1)  0100-> jump (type = 0)
     if(op[7:4] == 4'b1100)
        type = 1;
		else if(op[7:4] == 4'b0100)
        type = 0;
		else
			dis_out = pc_in + 1;
            //checks if jump
      if(type == 0) begin
			case(condition[3:0]) 
                    //EQ
                    4'b0000: begin
                                //check zero flag
                                if(flags[3] == 1) 
                                    dis_out = imm_in;
                                
                                else 
                                    dis_out = pc_in + 1;
                                
                             end
                    //NE            
                    4'b0001: begin
                                //check zero flag
                                if(flags[3] == 0) 
                                    dis_out = imm_in;
                                else 
                                    dis_out = pc_in + 1;
                             end
                    //GT        
                    4'b0110: begin
                                if((flags[3] == 1) || (flags[4] == 1))
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
                    //LE    
                    4'b0111: begin
                                if(flags[4] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
                endcase
            end
            
            //if branch
            else if(type == 1) begin
                case(condition[3:0])
                            //EQ
                    4'b0000: begin
                                if(flags[3] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
                    //NE            
                    4'b0001: begin
                                if(flags[3] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;                    
                             end
                    //GT        
                    4'b0110: begin
                                if((flags[3] == 1) || (flags[4] == 1))
                                    dis_out = pc_in + condition[11:4];
                                else 
                                    dis_out = pc_in + 1;
                             end
                    //LE    
                    4'b0111: begin
                                if(flags[4] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
                endcase
            end
		end
endmodule 