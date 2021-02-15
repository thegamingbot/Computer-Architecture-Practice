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
    input [n-1:0] in, input clk, input reset, output [n-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin: init
            DFF dff (in[i], clk, reset, out[i]);
        end
    endgenerate
endmodule
