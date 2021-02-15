/*
    A module to implement the ALU
    Inputs: Two 32-bit numbers (A, B), Select input for operation (s)
    Output: 32-bit number (C)
*/
module ALU(input [31:0] A, B, input [2:0] s, output reg [31:0] C);

    always @(A, B, s) begin
        case (s)
            /*
                0: Addition
            */
            3'b000: C = A + B;
            /*
                1: Subtraction
            */
            3'b001: C = A - B;
            /*
                2: Multiplication
            */
            3'b010: C = A * B;
            /*
                3: Division
            */
            3'b011: C = A / B;
            /*
                4: Modulus
            */
            3'b100: C = A % B;
            /*
                5: Bitwise AND
            */
            3'b101: C = A & B;
            /*
                6: Bitwise OR
            */
            3'b110: C = A | B;
            /*
                7: Bitwise XOR
            */
            3'b111: C = A ^ B;
        endcase
    end

endmodule
