/*
    A module that manages the register files
    Input: 32-bit number for writing (W), three 5-bit addresses (RA, RB for reading, RW for writing), 1-bit select for read / write, clock
    Output: Two 32-bit numbers read from the address RA and RB (A, B) 
*/
module RegisterFile(input [31:0] W, input [4:0] RA, RB, RW, input ReadWrite, clk, output [31:0] A, B);

    reg [31:0] registerFile [31:0];
    integer i;
    /*
        Initializing the register files with random numbers
    */
    initial begin
        /*
            For each register index, assign a random 32-bit number
        */
        for (i = 0; i < 32; i = i + 1) begin : registerFileInit
            registerFile[i] = $random;
        end
    end
    /*
        Assign the value at addresses RA and RB to A and B
    */
    assign A = registerFile[RA];
    assign B = registerFile[RB];

    always @ (negedge clk) begin
        /*
            If the select operation is write,
            assign the value W to address RW
        */
        if(ReadWrite) begin
            registerFile[RW] = W;
        end
    end

endmodule
