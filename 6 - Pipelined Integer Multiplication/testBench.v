`include "wallaceTreeMultiplier.v"

module top;

    reg [31:0] A, B;
    wire [63:0] S;
    reg clk;

    wallaceTreeMultiplier wm(A, B, clk, S);

    always #5 clk = ~clk;

    initial
    begin
        clk = 1'b1;
        A = 32'd3423;
        B = 32'd3413;
        #100
        $display("A =  %b (%d)\nB =  %b (%d)\nS = %b (%d)\n", A, A, B, B, S, S);
        
        A = 32'd6535473;
        B = 32'd67445575;
        #100
        $display("A =  %b (%d)\nB =  %b (%d)\nS = %b (%d)\n", A, A, B, B, S, S);
        
        #500
        $finish;
    end

endmodule
