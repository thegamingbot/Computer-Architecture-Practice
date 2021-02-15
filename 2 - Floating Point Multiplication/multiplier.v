/*
    A module that calculates the product of the inputs
*/
module multiplier (input [31:0] A, input B, output reg [31:0] C);
    
    always@(A, B)
    begin
        /*
            If B is 1, 
            A * B = A
        */
        if(B != 0)
            C = A;
        /*
            If B = 0,
            A * B = 0
        */
        else
            C = 32'b0000_0000_0000_0000_0000_0000_0000_0000;   
    end
    
endmodule
