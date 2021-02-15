module cacheMemory #(
    parameter size = 1024,
    // Number of words in a block
    parameter nWords = 16,
    // Size of each word
    parameter sWord = 32,
    // Address size
    parameter addrSize = 24,
    // Word offset size
    parameter offset = $clog2(nWords),
    // Block offset size
    parameter index = $clog2(size),
    // Tag size
    parameter tag = addrSize - offset - index
) ();
    
    reg [nWords - 1:0][sWord-1:0] cacheData [size-1:0];
    reg [tag-1:0] cacheTag [size-1:0];
    reg [1:0] cacheFlag [size-1:0];

    task initialize;
		integer i;
		for (i = 0; i < size; i = i + 1) begin
			cacheFlag[i] = 2'b00;
		end
	endtask

endmodule
