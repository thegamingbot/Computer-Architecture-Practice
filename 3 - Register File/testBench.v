`include "main.v"

module top;
  
    reg [4:0] RA, RB, RW;
    reg [2:0] s;
    reg clk;
    wire [31:0] A, B, W;

    always #5 clk = ~clk;

    main m_01 (RA, RB, RW, s, clk, A, B, W);
    
    initial begin
        $dumpfile("testBench.vcd"); 
        $dumpvars;
    end

    initial begin
        clk = 1'b1;
        $write("%c[0;31m",27);
        $display ("Addition: ");
        $write("%c[0m",27);
        RA = 5'b10010;
        RB = 5'b11111;
        RW = 5'b00000;
        s = 3'b000;
        #5
        $write("%c[0;31m",27);
        $display ("Subtraction: ");
        $write("%c[0m",27);
        RA = 5'b10100;
        RB = 5'b01101;
        RW = 5'b10010;
        s = 3'b001;
        #5
        $write("%c[0;31m",27);
        $display ("Multiplication: ");
        $write("%c[0m",27);
        RA = 5'b11100;
        RB = 5'b11101;
        RW = 5'b11010;
        s = 3'b010;
        #5
        $write("%c[0;31m",27);
        $display ("Division: ");
        $write("%c[0m",27);
        RA = 5'b11101;
        RB = 5'b01001;
        RW = 5'b01010;
        s = 3'b011;
        #5
        $write("%c[0;31m",27);
        $display ("Modulus: ");
        $write("%c[0m",27);
        RA = 5'b10110;
        RB = 5'b00100;
        RW = 5'b11011;
        s = 3'b100;
        #5
        $write("%c[0;31m",27);
        $display ("Bitwise AND: ");
        $write("%c[0m",27);
        RA = 5'b11000;
        RB = 5'b11100;
        RW = 5'b00111;
        s = 3'b101;
        #5
        $write("%c[0;31m",27);
        $display ("Bitwise OR: ");
        $write("%c[0m",27);
        RA = 5'b10110;
        RB = 5'b00101;
        RW = 5'b11110;
        s = 3'b110;
        #5
        $write("%c[0;31m",27);
        $display ("Bitwise XOR: ");
        $write("%c[0m",27);
        RA = 5'b10110;
        RB = 5'b00101;
        RW = 5'b11110;
        s = 3'b111;
        $finish;
    end

    initial begin
        $monitor ("A (R\tIndex: %d)\t= %b (%d)\nB (R\tIndex: %d)\t= %b (%d)\nC (W\tIndex: %d)\t= %b (%d)\n", RA, A, A, RB, B, B, RW, W, W);
    end

endmodule
