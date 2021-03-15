//Parallel Prefix
module Parallel_Prefix (X, Y, Z); 
//X Input Bits
//Y input carry
//Z Output carry

input [1:0] X;
input [1:0] Y;
	
output reg [1:0] Z;

	always@(X, Y)
	begin
		if( X == 2'b00 || X == 2'b11)
			assign Z = X;
		else
			assign Z = Y;
	end
	
endmodule
