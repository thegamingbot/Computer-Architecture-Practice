/*
    Include the required modules
*/
`include "RegisterFile.v"
`include "ALU.v"

/*
    Module to implement the running of a register file
    Input: Three 4-bit address (RA, RB for reading, RW for writing), select input for operation (s), clock
    Output: Three 32-bit numbers (A, B read from memory, W written to memory)
*/
module main (input [4:0] RA, RB, RW, input [2:0] s, input clk, output [31:0] A, B, W);

    wire [31:0] w1, w2;
    /*
        Read the numbers from the register file present at the address RA and RB
    */
    RegisterFile rf_01 ({32{1'bx}}, RA, RB, RW, 1'b0, clk, A, B);
    /*
        Perform the specified operation on the two numbers
    */
    ALU alu_01 (A, B, s, W);
    /*
        Write the output from the ALU at the address RW
    */
    RegisterFile rf_02 (W, RA, RB, RW, 1'b1, clk, w1, w2);

endmodule
