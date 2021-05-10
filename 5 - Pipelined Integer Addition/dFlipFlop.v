module DFF (
    input in, input clk, input reset, output reg out
);
    always @(posedge clk ) begin
        if (reset == 1'b0) begin
            out <= 1'b0;
        end
        else begin
            out <= in;
        end
    end
endmodule

module nDFF #(
    parameter n = 64
) (
    input [n-1:0] in, input clk, input reset, output reg [n-1:0] out
);
    always @(posedge clk ) begin
        if (reset == 1'b0) begin
            out = {n{1'b0}};
        end
        else begin
            out = in;
        end
    end
endmodule
