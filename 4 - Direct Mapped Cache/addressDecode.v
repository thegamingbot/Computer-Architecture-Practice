module addressDecode #(
    // Address size
    parameter addrSize = 30,
    // Word offset size
    parameter offset = 10,
    // Block offset size
    parameter index = 10,
    // Tag size
    parameter tag = 10
) (
    input [addrSize - 1:0] addr, output [tag-1:0] tagArr, output [index-1:0] indexArr, output [offset-1:0] offsetArr
);

    assign tagArr = addr[addrSize - 1:addrSize - offset - index];
    assign indexArr = addr[offset + index - 1:offset];
    assign offsetArr = addr[offset - 1:0];

endmodule
