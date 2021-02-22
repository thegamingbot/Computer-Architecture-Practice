/*
    Including the required modules
*/
`include "zeroInf.v"
`include "wallaceTreeMultiplier.v"
/*
    A module that mutiplies two numbers represented in IEEE 754 format
*/
module IEEEmultiply (input [31:0] a, input [31:0] b, input clk, output [31:0] c);

    /*
        Required registers and wires for the module
    */
    wire s1, s2, s3;
    wire [7:0] e1, e2, e3, e3F;
    wire [22:0] m1, m2, m3, m3F;
    wire [63:0] prod, prodD;
    wire [31:0] mm1, mm2;
    reg [47:0] mprod;
    reg [7:0] ex;
    integer i;
    /*
        Split the given 32-bit number into sign bit, exponent bits and mantissa bits
    */
    assign s1 = a[31];
    assign e1 = a[30:23];
    assign m1 = a[22:0];
    assign s2 = b[31];
    assign e2 = b[30:23];
    assign m2 = b[22:0];
    /*
        If any one of the operand is inf or zero,
        assign the same to the output
    */
    assign s3 = s1 ^ s2;
    /*
        Concatenating the assumed bit to the mantissa
        For denormal number (all exponent bits are 0), we concatenate the bitwise OR of the exponent, i.e. zero
        For normal numbers, we concatenate the bitwise OR of the exponent, i.e. one
    */
    assign mm1 = {|e1, m1};
    assign mm2 = {|e2, m2};
    /*
        Multiply the numbers using the Wallace Tree Multiplier module
    */
    wallaceTreeMultiplier wm_01 (mm1, mm2, clk, prod);
    nDFF #(64) ndff_prod (prod, clk, 1'b1, prodD);
    /*
        Normalizing the result to 1.m3 format
    */
    always @(*) begin
        /*
            Final exponent is the sum of e1, e2 and -127
            We take the product for from 47 to 0 (47 and 46 are the bits before the decimal point,
            for normalizing we need 1 bit before the decimal, we shift one left adding 1 to the exponent.)
            We also add the 1 we get from normalizing the product from step 3
        */
        ex = e1 + e2 - 7'b1111110;
        i = 0;
        /*
            Loop and increment the counter until we find a 1 in the product
        */
        while (prodD[47 - i] == 1'b0) begin
            i = i + 1;
        end
        /*
            Shift the product i steps left for normalizing
            Decrement the exponent by i amounts
        */
        mprod = prodD << i;
        ex = ex - i;
    end
    /*
        Copy the exponent, and first 23 bits from the modified product. 
    */
    assign e3 = ex;
    assign m3 = mprod[46:24];
    /*
        Modify the outputs to the edge cases, if any
    */
    zeroInf zf_01 (e1, m1, e2, m2, e3, m3, e3F, m3F);
    /*
        Concat the sign bit, exponent bits and the mantissa bits
    */
    assign c = {s3, e3F, m3F};

endmodule
