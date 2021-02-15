/*
    A module to normalize the mantissa sum and final exponent
*/
module normalization (input [31:0] sum, input [7:0] e1, input flag, output reg [7:0] e3, output reg [22:0] m3);

    /*
        Required registers and wires for the addition
    */
    reg [31:0] sum1;

    always @(sum) begin
        /*
            If there is a carry
            For addition - Increment the exponent
            For subtraction - Check for 0 case
        */
        if (sum[24] == 1'b1) begin
            /*
                Flag = 0 -> addition
                Increment the exponent
                Right shift the mantissa
            */
            if (flag == 1'b0) begin
                m3 = sum[23:1];
                e3 = e1 + 1'b1;
            end
            /*
                Flag = 1 -> subtraction
                Check if the assumed bit is zero
            */
            else begin
                if (sum[23] == 1'b0) begin
                    /*
                        If the mantissa sum is 0
                        Final output is 0 
                    */
                    if (sum[23:0] == {23{1'b0}}) begin
                        e3 = {8{1'b0}};
                        m3 = sum[22:0];
                    end
                    /*
                        Else
                        Shift left the sum, until there is a assumed one in the 23rd position
                    */
                    else begin
                        sum1 = sum;
                        e3 = e1;
                        /*
                            Left shift the sum
                            Decrement the exponent
                        */
                        while (sum1[23] == 1'b0) begin
                            sum1 = sum1 << 1;
                            e3 = e3 - 1'b1;
                        end
                        m3 = sum1[22:0];
                    end
                end
            end
        end
        /*
            Esle if the assumed one is 0
        */
        else if (sum[23] == 1'b0) begin
            if (sum[23] == 1'b0) begin
                /*
                    If the mantissa sum is 0
                    Final output is 0 
                */
                if (sum[23:0] == {23{1'b0}}) begin
                    e3 = {8{1'b0}};
                    m3 = sum[22:0];
                end
                /*
                    Else
                    Shift left the sum, until there is a assumed one in the 23rd position
                */
                else begin
                    sum1 = sum;
                    e3 = e1;
                    /*
                        Left shift the sum
                        Decrement the exponent
                    */
                    while (sum1[23] == 1'b0) begin
                        sum1 = sum1 << 1;
                        e3 = e3 - 1'b1;
                    end
                    m3 = sum1[22:0];
                end
            end
        end
        /*
            Else
            Copy the sum and exponent to the output
        */
        else begin
            m3 = sum[22:0];
            e3 = e1;
        end
    end

endmodule
