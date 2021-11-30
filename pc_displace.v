module pc_displace(pc_in, op, flags, imm_in, link_out, dis_out, condition);
     input [15:0] pc_in;
     input [7:0]  op;
     input [4:0]  flags;
     input [15:0] imm_in;
	  input [15:0] condition;

     
     output reg [15:0] dis_out, link_out;
     
     
     reg [1:0] type;
     
     // Flags[0] - Carry-bit
    // Flags[1] - Low flag: 1 if Rdest operand < Rsrc as UNSIGNED numbers
    // Flags[2] - Flag: F bit to signal arithmetic overflow
    // Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
    // Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
     
     
  
     
     always@(imm_in, pc_in, op, condition, flags) begin
	  
	       //1100 -> branch (type = 1)  0100-> jump (type = 0)
     if(op[7:4] == 4'b1100)
        type = 2'b01;
		else if(op[7:4] == 4'b0100)
        type = 2'b00;
		else
		  type = 2'b10;

       //checks if jump
      if(type == 2'b00) begin
			if(op[3:0] == 4'b1000) begin
					link_out = pc_in + 1;
					dis_out = imm_in;
			end
			else begin
				case(condition[3:0]) 
							  // Flags[0] - C: Carry-bit
							// Flags[1] - L: Low flag, 1 if Rdest operand < Rsrc as UNSIGNED numbers
							// Flags[2] - F: Flag bit to signal arithmetic overflow
							// Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
							// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
							
                    //EQ - Equal
                    4'b0000: begin
                                if(flags[3] == 1)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
                    //NE - Not Equal       
                    4'b0001: begin
                                if(flags[3] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;                    
                             end
									  
									  									  
						  //GE - Greater than or Equal
                    4'b1101: begin
                                if(flags[4] == 1 || flags[3] == 1)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //CS - Carry Set
                    4'b0010: begin
                                if(flags[0] == 1)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //CC - Carry Clear
                    4'b0011: begin
                                if(flags[0] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //HI - Higher than
                    4'b0100: begin
                                if(flags[1] == 1)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
									  
							//LS - Lower than or Same as
                    4'b0101: begin
                                if(flags[1] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //LO - Lower than	
                    4'b1010: begin
                                if(flags[1] == 0 && flags[3] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //HS - Higher than or Same as
                    4'b1011: begin
                                if(flags[1] == 1 || flags[3] == 1)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //GT - Greater than
                    4'b0110: begin
                                if(flags[4] == 1)
                                    dis_out = imm_in;
                                else 
                                    dis_out = pc_in + 1;
                             end
									  
						  //LE - Less than or Equal
                    4'b0111: begin
                                if(flags[4] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //FS - Flag Set
                    4'b1000: begin
                                if(flags[2] == 1)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //FC - Flag Clear
                    4'b1001: begin
                                if(flags[2] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //LT - Less than
                    4'b1100: begin
                                if(flags[2] == 0 && flags[3] == 0)
                                    dis_out = imm_in;
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //UC - Unconditional
                    4'b1110: begin
                                    dis_out = imm_in;
                             end
									  
						  // Never Jump
                    4'b1111: begin
											dis_out = pc_in + 1;
									  end
                endcase
            end
				end
					
					//if branch
            else if(type == 2'b01) begin
                case(condition[3:0])
					 
							// Flags[0] - C: Carry-bit
							// Flags[1] - L: Low flag, 1 if Rdest operand < Rsrc as UNSIGNED numbers
							// Flags[2] - F: Flag bit to signal arithmetic overflow
							// Flags[3] - Z: Set by comparison operation (1 if two operands are equal, cleared otherwise)
							// Flags[4] - N: Negative bit (1 if Rdest < Rsrc) as SIGNED numbers
							
                    //EQ - Equal
                    4'b0000: begin
                                if(flags[3] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
                    //NE - Not Equal       
                    4'b0001: begin
                                if(flags[3] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;                    
                             end
									  
									  									  
						  //GE - Greater than or Equal
                    4'b1101: begin
                                if(flags[4] == 1 || flags[3] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //CS - Carry Set
                    4'b0010: begin
                                if(flags[0] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //CC - Carry Clear
                    4'b0011: begin
                                if(flags[0] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //HI - Higher than
                    4'b0100: begin
                                if(flags[1] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
									  
							//LS - Lower than or Same as
                    4'b0101: begin
                                if(flags[1] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //LO - Lower than	
                    4'b1010: begin
                                if(flags[1] == 0 && flags[3] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //HS - Higher than or Same as
                    4'b1011: begin
                                if(flags[1] == 1 || flags[3] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //GT - Greater than
                    4'b0110: begin
                                if(flags[4] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else 
                                    dis_out = pc_in + 1;
                             end
									  
						  //LE - Less than or Equal
                    4'b0111: begin
                                if(flags[4] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //FS - Flag Set
                    4'b1000: begin
                                if(flags[2] == 1)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //FC - Flag Clear
                    4'b1001: begin
                                if(flags[2] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //LT - Less than
                    4'b1100: begin
                                if(flags[2] == 0 && flags[3] == 0)
                                    dis_out = pc_in + condition[11:4];
                                else
                                    dis_out = pc_in + 1;
                             end
									  
						  //UC - Unconditional
                    4'b1110: begin
										   dis_out = pc_in + condition[11:4];
                             end
									  
						  // Never Jump
                    4'b1111: begin
											dis_out = pc_in + 1;
									  end
						 endcase
					 end
					else if (type == 2'b10)
						dis_out = pc_in + 1;
					else
					dis_out = 16'b0;
		end
endmodule 