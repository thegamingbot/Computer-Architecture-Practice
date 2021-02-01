`include "main.v"

module top;

    reg [31:0] a, b;
    wire [31:0] s;

    adder com (a, b, s);

    initial begin
        /*
            Infinite + Normal number
        */
        #0 a = {1'b0, {8{1'b1}}, 23'b0}; b = {1'b0, {7{1'b1}}, 24'b111011};
        /*
            Denormal number + Normal number
        */
        #10 a = {31'b0,1'b1}; b = 32'b00111111110010100011110101110001;
        /*
            Normal number + Normal number
        */
        #20 a = 32'b01000110000111000100000000000000; b = 32'b11000101111110100000000000000000;
        /*
            Positive number + Negative number
        */
        #30 a = 32'b11000101111110100000000000000000; b = 32'b01000101111110100000000000000000;
        /*
            NaN + Normal Number
        */
        #40 a = {1'b0, {8{1'b1}}, 23'b1}; b = 32'b01000101111110100000000000000000;
    end

    initial
        $monitor($time, " a = %b\tb = %b\tsum = %b\t\n", a, b, s);

endmodule
