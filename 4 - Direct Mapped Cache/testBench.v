`include "main.v"

module top;

reg [23:0] address;
reg [31:0] data;
reg mode, clk;
wire [31:0] out;

main tb(
	.addr(address),
	.inData(data),
	.mode(mode),
	.clk(clk),
	.outData(out)
);

	initial begin
		tb.ram.initialize();
		tb.cache.initialize();

		clk = 1'b1;
		#50
		address = 24'b000000000000000000000000;
		mode = 1'b0;
		
		#50
		address = 24'b101001111110010111111011;
		data = 32'd46426;
		mode = 1'b1;
		
		#50
		address = 24'b101001111110010111111011;
		data = 32'd4235;
		mode = 1'b0;
		#50
		$finish;
	end

	initial
	$monitor("Address = %d\tInput Data = %d\tMode = %d\tOutput Data = %d", address, data, mode, out);

	always #20 clk = ~clk;

endmodule 
