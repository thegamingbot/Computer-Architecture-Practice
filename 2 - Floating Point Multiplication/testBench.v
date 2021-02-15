/*
    Including the required modules
*/
`include "main.v"
/*
    A module that mutiplies two numbers represented in IEEE 754 format
*/
module top;

    /*
        Required registers and wires for the addition
    */
    reg [31:0] a, b;
    wire [31:0] c;
    /*
        Module two multiply two numbers represented in IEEE 754 format
    */
    IEEEmultiply mul_01 (a, b, c);

    initial begin
        /*
            Infinity * Normal number
            a = inf
            b = 4.73871160175e-38
            actual product = inf
            c = inf
        */
        #0     a = 32'b01111111100000000000000000000000;   b = 32'b00000001100000010000000000000000;
        /*
            Zero * Infinity
            a = 0
            b = inf
            actual product = NaN
            c = NaN
        */
        #10    a = 32'b00000000000000000000000000000000;   b = 32'b01111111100000000000000000000000;
        /*
            Normal number * Normal number (without truncation)
            a = 2
            b = 32
            actual product = 64
            c = 64
        */
        #20    a = 32'b01000000000000000000000000000000;   b = 32'b01000010000000000000000000000000;
        /*
            Normal number * Normal number
            a = 1.32923813699e+36
            b = -3.33073482491e-23
            actual product = -4.4273398e+13
            c = -4.42733953024e+13
        */
        #30    a = 32'b01111011100000000000000001000000;   b = 32'b10011010001000010001000010000000;
        /*
            Normal number * Denormal number
            a = 1.20923019089e+24
            b = 9.41672568026e-41
            actual product = 1.1386989e-16
            c = 5.69349408237e-17
        */
        #40    a = 32'b01100111100000000000100001000000;   b = 32'b00000000000000010000011010000000;
        /*
            NaN * Normal number
            a = NaN
            b = 1.66733009839e-24
            actual product = NaN
            c = NaN
        */
        #50    a = 32'b01100111100000000000100001000000;   b = 32'b0000000000000000001011010001000;
    end

    initial
        $monitor (" a = %b\tb = %b\tc = %b\n", a, b, c);

endmodule
