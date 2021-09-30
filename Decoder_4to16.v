module Decoder_4to16(Decode_In, Decode_Out);

input [4:0]   Decode_In;
output [15:0] Decode_Out;

   parameter mask = 16'b0000_0000_0000_0001;

assign Decode_Out = 
					(Decode_In == 4'b0000) ? mask:
               (Decode_In == 4'b0001) ? mask<<1:
               (Decode_In == 4'b0010) ? mask<<2:
               (Decode_In == 4'b0011) ? mask<<3:
               (Decode_In == 4'b0100) ? mask<<4:
               (Decode_In == 4'b0101) ? mask<<5:
               (Decode_In == 4'b0110) ? mask<<6:
               (Decode_In == 4'b0111) ? mask<<7:
               (Decode_In == 4'b1000) ? mask<<8:
               (Decode_In == 4'b1001) ? mask<<9:
               (Decode_In == 4'b1010) ? mask<<10:
               (Decode_In == 4'b1011) ? mask<<11:
               (Decode_In == 4'b1100) ? mask<<12:
               (Decode_In == 4'b1101) ? mask<<13:
               (Decode_In == 4'b1110) ? mask<<14:
               (Decode_In == 4'b1111) ? mask<<15: 16'bxxxx_xxxx_xxxx_xxxx;

endmodule
