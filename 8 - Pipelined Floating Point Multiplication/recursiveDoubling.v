/*
    Include the required files
*/
`include "level.v"
`include "helpers.v"

/*
	A module that adds A nd B using recursive doubling technique
*/
module RecursiveDoubling(A, B, clk, S, Ca);

	/*
        Required registers and wires for the addition
    */
	input [63:0] A, B;
	input clk;
	output [63:0] S;
	output Ca;
	wire [127:0] kgp, temp1, temp2, temp3, temp4, temp5, temp6;
	wire [127:0] kgpD, temp1D, temp2D, temp3D, temp4D, temp5D, temp6D;
	wire [63:0] cin, cinD;
	genvar i;
	/*
		Genreate the KGP bits
	*/
	KGP kgp_01 (A, B, kgp);
	nDFF #(128) dff_kgp (kgp, clk, 1'b1, kgpD);
	/*
		Level 1
	*/
	level #(1) level_01 (kgpD, temp1);
	nDFF #(128) dff_01 (temp1, clk, 1'b1, temp1D);
	/*
		Level 2
	*/
	level #(2) level_02 (temp1D, temp2);
	nDFF #(128) dff_02 (temp2, clk, 1'b1, temp2D);
	/*
		Level 3
	*/
	level #(3) level_03 (temp2D, temp3);
	nDFF #(128) dff_03 (temp3, clk, 1'b1, temp3D);
	/*
		Level 4
	*/
	level #(4) level_04 (temp3D, temp4);
	nDFF #(128) dff_04 (temp4, clk, 1'b1, temp4D);
	/*
		Level 5
	*/
	level #(5) level_05 (temp4D, temp5);
	nDFF #(128) dff_05 (temp5, clk, 1'b1, temp5D);
	/*
		Level 6
	*/
	level #(6) level_06 (temp5D, temp6);
	nDFF #(128) dff_06 (temp6, clk, 1'b1, temp6D);
	/*
		Generate the carry bits
	*/
	carry carry_01 (temp6D, cin, Ca);
	nDFF #(64) dff_carry (cin, clk, 1'b1, cinD);
	/*
		Generate the final sum
	*/
	assign S[0] = A[0] ^ B[0];
	for(i = 1; i < 64; i = i + 1) begin
		assign S[i] = A[i] ^ B[i] ^ cinD[i - 1];
	end

endmodule
