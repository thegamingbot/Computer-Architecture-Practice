`include "parallelPrefix.v"

module level #(
    parameter nLevel = 1
) (
    input [127:0] kgp, output [127:0] temp1
);
    
	parallelPrefixCircuit PPC0[2**(nLevel-1)-1:0](kgp[2**nLevel-1:0], {2**nLevel{1'b0}}, temp1[2**nLevel-1:0]);
	parallelPrefixCircuit PPC1[63:2**(nLevel-1)](kgp[127:2**nLevel], temp1[125:2**nLevel-2], temp1[127:2**nLevel]);

endmodule
