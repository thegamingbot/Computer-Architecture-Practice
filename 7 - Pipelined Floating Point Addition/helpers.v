module KGP (
    input [31:0] A, input [31:0] B, output [63:0] C
);

    for (i = 0; i < 32; i = i + 1) begin
		assign C[2 * i] = A[i];
		assign C[2 * i + 1] = B[i];
	end

endmodule

module carry (
    input [63:0] in, output [31:0] out, output Ca
);

    for(i = 0; i < 32; i = i + 1) begin
		assign out[i] = in[2 * i + 1];
	end
	assign Ca = out[31];

endmodule
