/*
    Include the required files
*/
`include "recursiveDoubling.v"
`include "operand2.v"
`include "normalization.v"

/*
    A module that computes the sum / difference of the two manissas and 
    outputs the normalized output mantissa and the exponent
*/
module compute (input s1, input s2, input [23:0] m1, input [23:0] m2, input [7:0] e1, input clk, output [22:0] m3, output [7:0] e3);

    /*
        Required registers and wires for the addition
    */
    wire [23:0] op2;
    wire [31:0] sum, sumD;
    wire carry, flag;

    /*
        Get the second operand
        For addition - Use the modified mantissa
        For subtraction - Use the 2's complement of the modified mantissa 
    */
    operand2 op_01 (s1, s2, m2, op2, flag);
    /*
        Recursive doubling of the modified mantissa 1 and operand 2
    */
    RecursiveDoubling RD ({{8{1'b0}}, m1}, {{8{1'b0}}, op2}, clk, sum, carry);
    nDFF #(32) ndff_sum (sum, clk, 1'b1, sumD);
    /*
        Normalize the output mantissa and the exponent 
    */
    normalization denorm_01 (sumD, e1, flag, e3, m3);

endmodule
