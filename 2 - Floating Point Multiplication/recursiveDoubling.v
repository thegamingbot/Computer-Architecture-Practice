/*
    Include the required files
*/
`include "parallelPrefixCircuit.v"
/*
	A module that adds A nd B using recursive doubling technique
*/
module RecursiveDoubling(input [63:0] A, input [63:0] B, output [63:0] S, output Ca);
	
	/*
        Required registers and wires for the addition
    */
	wire [127:0] kgp, temp1, temp2, temp3, temp4, temp5, temp6;
	wire[63:0] cin;
	genvar i;
	/*
		Genreate the KGP bits
	*/
	for(i = 0; i < 64; i = i + 1)
	begin
		assign kgp[2 * i] = A[i];
		assign kgp[2 * i + 1] = B[i];
	end
	/*
		Level 0
	*/
	parallelPrefixCircuit PPC0(kgp[1:0], 2'b00, temp1[1:0]);
	parallelPrefixCircuit PPC1[62:0](kgp[127:2], temp1[125:0], temp1[127:2]);
	/*
		Level 1
	*/
	parallelPrefixCircuit PPC2[1:0](temp1[3:0], 4'b00, temp2[3:0]);
	parallelPrefixCircuit PPC3[61:0](temp1[127:4], temp2[125:2], temp2[127:4]);
	/*
		Level 2
	*/
	parallelPrefixCircuit PPC5[3:0](temp2[7:0], 8'b00, temp3[7:0]);
	parallelPrefixCircuit PPC6[59:0](temp2[127:8], temp3[125:6], temp3[127:8]);
	/*
		Level 2
	*/
	parallelPrefixCircuit PPC7[7:0](temp3[15:0], 16'b00, temp4[15:0]);
	parallelPrefixCircuit PPC8[55:0](temp3[127:16], temp4[125:14], temp4[127:16]);
	/*
		Level 3
	*/
	parallelPrefixCircuit PPC9[15:0](temp4[31:0], 32'b00, temp5[31:0]);
	parallelPrefixCircuit PPC10[47:0](temp4[127:32], temp5[125:30], temp5[127:32]);
	/*
		Level 4
	*/
	parallelPrefixCircuit PPC11[31:0](temp5[63:0], 64'b00, temp6[63:0]);
	parallelPrefixCircuit PPC12[31:0](temp5[127:64], temp6[125:62], temp6[127:64]);
	/*
		Generate the carry bits
	*/
	for(i = 0; i < 64; i = i + 1)
	begin
		assign cin[i] = temp6[2 * i + 1];
	end
	assign Ca = cin[63];
	/*
		Generate the final sum
	*/
	assign S[0] = A[0] ^ B[0];
	for(i = 1; i < 64; i = i + 1)
	begin
		assign S[i] = A[i] ^ B[i] ^ cin[i - 1];
	end

endmodule
