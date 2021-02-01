/*
    A module to concatenate the sign, exponent and mantissa bits
    with respect to the edge cases
*/
module edgeCases (input [7:0] e1, input[22:0] m1, input s3, input [7:0] e3, input[22:0] m3, output reg [31:0] s);

    always @ (e3 or m3)
    begin
        /*
            If the larger number is infinity
            inf + number = inf
            Concat the value of infinity in the output sum
        */
        if(&e1 == 1'b1 && |m1 == 1'b0) begin
            s = {s3, {e1, m1}};
        end
        /*
            If the larger number is NaN
            NaN + number = NaN
            Concat the value of NaN in the output sum with output mantissa
        */
        else if (&e1 == 1'b1 && |m1 != 1'b0) begin
            s = {s3, {e1, m3}};
        end
        /*
            If neither edge case satisfies
            COncat the output exponent and mantissa
        */
        else begin
            s = {s3, {e3, m3}};
        end
    end

endmodule
