/*
    Include the required files
*/
`include "parallelPrefix.v"

/*
	A module that adds A nd B using recursive doubling technique
*/
module RecursiveDoubling(A, B, S, Ca);

	/*
        Required registers and wires for the addition
    */
	input [31:0] A, B;
	output [31:0] S;
	output Ca;
	wire [63:0] kgp, temp1, temp2, temp3, temp4, temp5;
	wire[31:0] cin;
	genvar i;
	
	/*
		Genreate the KGP bits
	*/
	for(i = 0; i < 32; i = i + 1) begin
		assign kgp[2 * i] = A[i];
		assign kgp[2 * i + 1] = B[i];
	end
	
	/*
		Level 1
	*/
	parallelPrefixCircuit PPC0(kgp[1:0], 2'b00, temp1[1:0]);
	parallelPrefixCircuit PPC1[31:1](kgp[63:2], temp1[61:0], temp1[63:2]);
	/*
		Level 2
	*/
	parallelPrefixCircuit PPC2[1:0](temp1[3:0], 4'b00, temp2[3:0]);
	parallelPrefixCircuit PPC3[31:2](temp1[63:4], temp2[61:2], temp2[63:4]);
	/*
		Level 3
	*/
	parallelPrefixCircuit PPC5[3:0](temp2[7:0], 8'b00, temp3[7:0]);
	parallelPrefixCircuit PPC6[31:4](temp2[63:8], temp3[61:6], temp3[63:8]);
	/*
		Level 4
	*/
	parallelPrefixCircuit PPC7[7:0](temp3[15:0], 16'b00, temp4[15:0]);
	parallelPrefixCircuit PPC8[31:8](temp3[63:16], temp4[61:14], temp4[63:16]);
	/*
		Level 5
	*/
	parallelPrefixCircuit PPC9[15:0](temp4[31:0], 32'b00, temp5[31:0]);
	parallelPrefixCircuit PPC10[31:16](temp4[63:32], temp5[61:30], temp5[63:32]);
	/*
		Generate the carry bits
	*/
	for(i = 0; i < 32; i = i + 1) begin
		assign cin[i] = temp5[2 * i + 1];
	end
	assign Ca = cin[31];
	/*
		Generate the final sum
	*/
	assign S[0] = A[0] ^ B[0];
	for(i = 1; i < 32; i = i + 1) begin
		assign S[i] = A[i] ^ B[i] ^ cin[i - 1];
	end


endmodule
