`include "main.v"

module top;

    reg [31:0] a, b;
    wire [31:0] s;
    reg clk;

    adder com (a, b, clk, s);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b1;
        /*
            Infinite + Normal number
        */
        a = {1'b0, {8{1'b1}}, 23'b0}; b = {1'b0, {7{1'b1}}, 24'b111011};
        #100
        $display("a = %b\tb = %b\tsum = %b\t\n", a, b, s);
        /*
            Denormal number + Normal number
        */
        a = {31'b0,1'b1}; b = 32'b00111111110010100011110101110001;
        #100
        $display("a = %b\tb = %b\tsum = %b\t\n", a, b, s);
        /*
            Normal number + Normal number
        */
        a = 32'b01000110000111000100000000000000; b = 32'b11000101111110100000000000000000;
        #100
        $display("a = %b\tb = %b\tsum = %b\t\n", a, b, s);
        /*
            Positive number + Negative number
        */
        a = 32'b11000101111110100000000000000000; b = 32'b01000101111110100000000000000000;
        #100
        $display("a = %b\tb = %b\tsum = %b\t\n", a, b, s);
        /*
            NaN + Normal Number
        */
        a = {1'b0, {8{1'b1}}, 23'b1}; b = 32'b01000101111110100000000000000000;
        #100
        $display("a = %b\tb = %b\tsum = %b\t\n", a, b, s);
        #100
        $finish;
    end

endmodule
