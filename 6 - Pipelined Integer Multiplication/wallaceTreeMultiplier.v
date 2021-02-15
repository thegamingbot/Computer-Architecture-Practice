/*
    Including the required modules
*/
`include "multiplier.v"
`include "carrySaveAdder.v"
`include "recursiveDoubling.v"
`include "dFlipFlop.v"
/*
    A module for implementation of the wallace tree multiplierss
*/
module wallaceTreeMultiplier (input [31:0] A, input [31:0] B, input clk, output [63:0] C);

    /*
        Required registers and wires for the module
    */
    wire [63:0] AB [31:0], temp1 [31:0];
    wire [31:0] temp [31:0];
    wire [63:0] s [30:0], sD [30:0];
    wire [63:0] c [30:0], cD [30:0];
    wire K;
    genvar i;
    
    /*
        Generate the partial products of A and B
    */
    generate
        for(i = 0; i < 32; i = i + 1) begin : and_loop
            /*
                Mulitply A with ith bit of B
            */
            multiplier mul(A, B[i], temp[i]);
            /*
                Concat 31 bits to the product and shift it i times
            */
            assign temp1[i] = {{32{1'b0}}, temp[i]};
            assign AB[i] = temp1[i] << i;
        end
    endgenerate

    // Adding the partial products and the generated sum and carry using carry save adder
    carrySaveAdder ca01(AB[0], AB[1], AB[2], s[0], c[0]);
    carrySaveAdder ca02(AB[3], AB[4], AB[5], s[1], c[1]);
    carrySaveAdder ca03(AB[6], AB[7], AB[8], s[2], c[2]);
    carrySaveAdder ca04(AB[9], AB[10], AB[11], s[3], c[3]);
    carrySaveAdder ca05(AB[12], AB[13], AB[14], s[4], c[4]);
    carrySaveAdder ca06(AB[15], AB[16], AB[17], s[5], c[5]);
    carrySaveAdder ca07(AB[18], AB[19], AB[20], s[6], c[6]);
    carrySaveAdder ca08(AB[21], AB[22], AB[23], s[7], c[7]);
    carrySaveAdder ca09(AB[24], AB[25], AB[26], s[8], c[8]);
    carrySaveAdder ca10(AB[27], AB[28], AB[29], s[9], c[9]);
    generate
        for (i = 0; i < 10; i = i + 1) begin: level_01
            nDFF #(64) ndff_11 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_12 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate

    carrySaveAdder ca11(sD[0], cD[0], sD[1], s[10], c[10]);
    carrySaveAdder ca12(cD[1], sD[2], cD[2], s[11], c[11]);
    carrySaveAdder ca13(cD[3], sD[3], sD[4], s[12], c[12]);
    carrySaveAdder ca14(cD[4], sD[5], cD[5], s[13], c[13]);
    carrySaveAdder ca15(sD[6], cD[6], sD[7], s[14], c[14]);
    carrySaveAdder ca16(cD[7], cD[8], sD[8], s[15], c[15]);
    carrySaveAdder ca17(sD[9], cD[9], AB[30], s[16], c[16]);
    generate
        for (i = 10; i < 17; i = i + 1) begin: level_02
            nDFF #(64) ndff_21 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_22 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate

    carrySaveAdder ca18(sD[10], cD[10], sD[11], s[17], c[17]);
    carrySaveAdder ca19(cD[11], sD[12], cD[12], s[18], c[18]);
    carrySaveAdder ca20(cD[13], sD[13], sD[14], s[19], c[19]);
    carrySaveAdder ca21(cD[14], cD[15], sD[15], s[20], c[20]);
    carrySaveAdder ca22(sD[16], cD[16], AB[31], s[21], c[21]);
    generate
        for (i = 17; i < 22; i = i + 1) begin: level_03
            nDFF #(64) ndff_31 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_32 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate

    carrySaveAdder ca23(sD[17], cD[17], sD[18], s[22], c[22]);
    carrySaveAdder ca24(cD[18], sD[19], cD[19], s[23], c[23]);
    carrySaveAdder ca25(cD[20], sD[20], sD[21], s[24], c[24]);
    generate
        for (i = 22; i < 25; i = i + 1) begin: level_04
            nDFF #(64) ndff_41 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_42 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate

    carrySaveAdder ca26(sD[22], cD[22], sD[23], s[25], c[25]);
    carrySaveAdder ca27(cD[23], sD[24], cD[24], s[26], c[26]);
    generate
        for (i = 25; i < 27; i = i + 1) begin: level_05
            nDFF #(64) ndff_51 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_52 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate

    carrySaveAdder ca28(cD[25], sD[25], sD[26], s[27], c[27]);
    carrySaveAdder ca29(cD[26], cD[21], {64{1'b0}}, s[28], c[28]);
    generate
        for (i = 27; i < 29; i = i + 1) begin: level_06
            nDFF #(64) ndff_61 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_62 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate
    
    carrySaveAdder ca30(sD[27], cD[27], sD[28], s[29], c[29]);
    generate
        for (i = 29; i < 30; i = i + 1) begin: level_07
            nDFF #(64) ndff_71 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_72 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate

    carrySaveAdder ca31(cD[28], sD[29], cD[29], s[30], c[30]);
    generate
        for (i = 30; i < 31; i = i + 1) begin: level_08
            nDFF #(64) ndff_81 (s[i], clk, 1'b1, sD[i]);
            nDFF #(64) ndff_82 (c[i], clk, 1'b1, cD[i]);
        end
    endgenerate
    /*
        Add the final sum and carry using recursive doubling adder
    */
    RecursiveDoubling RD64(sD[30], cD[30], clk, C, K);

endmodule
