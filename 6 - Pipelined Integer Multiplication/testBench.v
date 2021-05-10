`include "wallaceTreeMultiplier.v"

module top;

    reg [31:0] A, B;
    wire [63:0] S;
    reg clk;

    wallaceTreeMultiplier wm(A, B, clk, S);

    always #1 clk = ~clk;

    initial
    begin
        clk = 1'b1;
        A = 32'd1021;
        B = 32'd10000000;
        #5
        A = 32'd65354733;
        B = 32'd67445575;
        
        #500
        $finish;
    end

    initial begin
        $monitor($time, " A =  %d\tB =  %d\tS = %d", A, B, S);
    end

endmodule
