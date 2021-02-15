/*
	A module that genrates the parallel prefix bits
*/
module parallelPrefixCircuit(a, b, c);

	/*
        Required registers and wires for the addition
    */
    input [1:0] a,b;
	output reg [1:0] c;

	always@(a, b)
	begin
		/*
			If the a bits are 00 or 11
			outputs bits are a bits
		*/
		if(a == 2'b00 || a == 2'b11)
			assign c = a;
		/*
			Else
			output bits are b bits
		*/
		else
			assign c = b;
	end
	
endmodule
