module mainMemory #(
    parameter size = 16777216,
    // Number of words in a block
    parameter nWords = 16,
    // Size of each word
    parameter sWord = 32
) ();

    reg [nWords*sWord-1:0] memory [size - 1:0];
    
    task initialize;
        integer i, j;
        for (i = 0; i < size; i = i + 1) begin
            memory[i] = {nWords{$random}};
        end
    endtask

endmodule
