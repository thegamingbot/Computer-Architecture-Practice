`include "mainMemory.v"
`include "cacheMemory.v"
`include "addressDecode.v"

module main #(
    parameter memorySize = 16777216,
    parameter cacheSize = 1024,
    // Number of words in a block
    parameter nWords = 16,
    // Size of each word
    parameter sWord = 32,
    // Address size
    parameter addrSize = $clog2(memorySize),
    // Word offset size
    parameter offset = $clog2(nWords),
    // Block offset size
    parameter index = $clog2(cacheSize),
    // Tag size
    parameter tag = addrSize - offset - index
) (
    // Mode = 0: Read
    // Mode = 1: Write
    input clk, input [addrSize - 1:0] addr, input [sWord - 1:0] inData, input mode, output reg [sWord - 1:0] outData
);
    
    wire [tag - 1:0] tagArr;
    wire [offset-1:0] offsetArr;
    wire [index - 1:0] indexArr;

    addressDecode #(addrSize, offset, index, tag) addr_01 (addr, tagArr, indexArr, offsetArr);

    cacheMemory #(cacheSize, nWords, sWord, addrSize, offset, index, tag) cache();
    mainMemory #(memorySize, nWords, sWord) ram();

    always @(posedge clk) begin
        if (cache.cacheFlag[indexArr] == 2'b11) begin
            $write("%c[0;31m",27);
            $display("Dirty data updated in main memory");
            $write("%c[0m",27);
            ram.memory[{cache.cacheTag[indexArr], indexArr}] = cache.cacheData[indexArr];
            cache.cacheFlag[indexArr] = 2'b10;
        end
        if (cache.cacheTag[indexArr] == tagArr) begin
            $write("%c[0;32m",27);
            $display("Hit in cache memory");
            $write("%c[0m",27);
        end
        else begin
            $write("%c[0;33m",27);
            $display("Miss in cache memory");
            $write("%c[0m",27);
            cache.cacheData[indexArr] = ram.memory[{tagArr, indexArr}];
            cache.cacheFlag[indexArr] = 2'b10;
            cache.cacheTag[indexArr] = tagArr;
        end
        if (mode == 1'b1) begin
            $write("%c[0;34m",27);
            $display("Data update in cache");
            $write("%c[0m",27);
            cache.cacheData[indexArr][offsetArr] = inData;
            cache.cacheFlag[indexArr] = 2'b11;
        end
        else if (mode == 1'b0) begin
            $write("%c[0;35m",27);
            $display("Data read from cache");
            $write("%c[0m",27);
            outData = cache.cacheData[indexArr][offsetArr];
        end
    end

endmodule
