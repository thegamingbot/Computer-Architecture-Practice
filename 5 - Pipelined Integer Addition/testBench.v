`include "recursiveDoubling.v"

module top;

    reg [31:0] A, B;
    wire [32:0] S;
    reg clk;

    RecursiveDoubling rd(A, B, clk, S[31:0], S[32]);

    always #1 clk = ~clk;

    initial
    begin
        clk = 1'b1;
        A = 32'd1200;
        B = 32'd1000;
        
        #15 A = 32'b0011_0100_1100_1111_0011_0110_1100_1101;
        B = 32'b1001_1100_1000_1111_0000_1100_0110_1011;
        
        #20
        $finish;
    end

    initial begin
        $monitor($time, " A =  %d\tB =  %d\tS = %d", A, B, S);
    end

endmodule
