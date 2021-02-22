/*
    A module that adds three inputs and generates the sum and carry bits
*/
module fullAdder (input a, input b, input cin, output sum, output ca);

    /*
        Required wires for the module
    */
    wire w1, w2, w3, w4, w5;
    /*
        Generating the sum of the inputs 
    */
    xor xor_0 (w1, a, b);
    xor xor_1 (sum, w1, cin);
    /*
        Generating the carry of the inputs
    */
    and and_0 (w2, a, b);
    and and_1 (w3, a, cin);
    and and_2 (w4, b, cin);
    or  or_0 (w5, w2, w3);
    or  or_1 (ca, w4, w5);

endmodule

/*
    A module that adds three 64 it numbers and generates the sum and carry outputs
*/
module carrySaveAdder (input [63:0] X, input [63:0] Y, input [63:0] Z, output [63:0] S, output [63:0] C);

    /*
        Inital carry bit is 0
    */
    assign C[0] = 1'b0;
    genvar i;
    generate
        /*
            loop through the bits 
        */
        for(i = 0; i < 63; i = i + 1) begin: full_adder
            /*
                Add the bits at current index and store its sum and carry in respective indices
            */
            fullAdder fa(X[i], Y[i], Z[i], S[i], C[i + 1]);
        end
    endgenerate
    /*
        Final sum bit is 0
    */
    assign S[63] = 1'b0;

endmodule
