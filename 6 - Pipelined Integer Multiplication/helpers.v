module KGP (
    input [63:0] A, input [63:0] B, output [127:0] C
);

    for (i = 0; i < 64; i = i + 1) begin
		assign C[2 * i] = A[i];
		assign C[2 * i + 1] = B[i];
	end

endmodule

module carry (
    input [127:0] in, output [63:0] out, output Ca
);

    for(i = 0; i < 64; i = i + 1) begin
		assign out[i] = in[2 * i + 1];
	end
	assign Ca = out[31];

endmodule
