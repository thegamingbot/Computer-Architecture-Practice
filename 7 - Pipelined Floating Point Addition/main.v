/*
    Include the required files
*/
`include "compare.v"
`include "compute.v"
`include "edgeCases.v"
`include "barrelShifter.v"
/*
    A module that adds two numbers represented in IEEE 754 format
*/
module adder(input [31:0] a, input [31:0] b, input clk, output [31:0] s);

    /*
        Required registers and wires for the addition
    */
    wire [31:0] x1, x2;
    wire s1, s2, s3;
    wire [7:0] e1, e2, e3, d;
    wire [22:0] m1, m2, m3;
    wire [23:0] mm1, mm2, mm2D;
    wire c;
    /*
        Compare a and b
        If a < b, b and a are stored in a1 and b1 respectively
        Else, a and b are stored in a1 and b1 respectively
    */
    compare c_01(.a(a), .b(b), .a1(x1), .b1(x2));
    /*
        Split the given 32-bit number into sign bit, exponent bits and mantissa bits
    */
    assign s1 = x1[31];
    assign e1 = x1[30:23];
    assign m1 = x1[22:0];
    assign s2 = x2[31];
    assign e2 = x2[30:23];
    assign m2 = x2[22:0];
    /*
        Copying the sign of the first number
    */
    assign s3 = s1;
    /*
        Calculating the difference in the exponents, D
        Denormalize the second mantissa
    */
    assign d = e1 - e2;
    assign mm1 = {|e1, m1};
    barrelRight #(24, 5) br ({|e2, m2}, d[4:0], mm2);
    nDFF #(24) ndff_mm2 (mm2, clk, 1'b1, mm2D);

    /*
        Compute the sum / difference of the modified manitssas
    */
    compute c_02(s1, s2, mm1, mm2D, e1, clk, m3, e3);
    /*
        Concatenation of the sign, exponent and mantissa bits in accordance to the edge cases
    */
    edgeCases ec_01 (e1, m1, s3, e3, m3, s);

endmodule
