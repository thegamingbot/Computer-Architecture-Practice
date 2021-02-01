/*
    A module to compare the modulus of two numbers (a and b) represented in IEEE 754 format
    and stores the larger number in a1 and the other in b1
*/
module compare(input [31:0] a, input [31:0] b, output reg [31:0] a1, output reg [31:0] b1);

    always @(a, b) begin
        /*
            If |b| > |a|
            Swap the numbers and assign to a1, b1
        */
        if(b[30:0] > a[30:0]) begin
            b1 = a;
            a1 = b;
        end
        /*
            Else
            Assign the numbers to a1, b1
        */
        else begin
            a1 = a;
            b1 = b;
        end
    end

endmodule
