/*
    A module that generates the second operand
    For addition - the modified mantissa
    For subtraction - 2's complement of the modified mantissa
*/
module operand2 (input s1, input s2, input [23:0] m2, output reg [23:0] op2, output reg flag);

    always @(s1, s2) begin
        /*
            If the sign bits are same
            Addition
        */
        if (s1 == s2) begin
            op2 = m2;
            flag = 1'b0;
        end
        /*
            If the sign bits are different
            Subtraction
        */
        else begin
            op2 = ~m2 + 1'b1;
            flag = 1'b1;
        end
    end

endmodule
