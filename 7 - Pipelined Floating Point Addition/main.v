`include "RecursiveDoubling.v"
`include "1s_complement.v"
`include "EightBitAdder.v"
`include "barrel_shifter.v"

module checknswap(input [31:0]operand1, input [31:0]operand2, output reg [31:0]new_operand1, output reg [31:0]new_operand2); 
	always @(operand1 | operand2) begin
        if(operand2[30:0] > operand1[30:0]) begin
			new_operand2 = operand1;
			new_operand1 = operand2;
        end
        else begin
			new_operand1 = operand1;
			new_operand2 = operand1;
        end
    end
endmodule

module IEEE754(input [31:0]operand, output sign, output [7:0]exponent, output [22:0]mantissa); 
    assign sign = operand[31];
    assign exponent = operand[30:23];
    assign mantissa = operand[22:0];
endmodule

module twos_complement_exponent(input [7:0]exponent, output [7:0]twos_complemented_exponent);
	assign twos_complemented_exponent = ~exponent + 1'b1;
endmodule

module modified_mantissa(input [7:0]exponent, input [22:0]mantissa, output [23:0]modified_mantissa);
	assign modified_mantissa = {|exponent, mantissa};
endmodule

module sign(input sign1, input sign2, output sign);
	assign sign = sign1^sign2;
endmodule

module ones_complement_mantissa(input [31:0]mantissa, input sign, output [31:0]ones_complemented_mantissa);
	assign ones_complemented_mantissa = {32{sign}}^mantissa;
endmodule

module SPFP_adder;

	reg clk;

	reg [31:0] operand1;
	reg [31:0] operand2;

	wire [31:0] new_operand1;
	wire [31:0] new_operand2;

	checknswap cs1(operand1, operand2, new_operand1, new_operand2);

	genvar j;
	wire [31:0] sum;

	wire [0:0] sign1, sign2;
	wire [7:0] exponent1, exponent2, E1, E2;
	wire [22:0] mantissa1, mantissa2, M1, M2;

	reg [0:0] final_sign;
	reg [7:0] final_exponent;
	reg [22:0] final_mantissa, temporary;

	wire [7:0] D; 
	wire [7:0] T2;

	IEEE754 i1(new_operand1, sign1, exponent1, mantissa1);
	
	nDFF #(8) dff01a (exponent1, clk, 1'b1, E1);
	nDFF #(23) dff01b (mantissa1, clk, 1'b1, M1);
	
	IEEE754 i2(new_operand2, sign2, exponent2, mantissa2);
	
	nDFF #(8) dff02a (exponent2, clk, 1'b1, E2);
	nDFF #(23) dff02b (mantissa2, clk, 1'b1, M2);

	wire [7:0] twos_complemented_exponent2;
	wire [7:0] T1;
	wire cout;
	wire [22:0] shifted_mantissa;

	twos_complement_exponent t1(E2, twos_complemented_exponent2);
	
	nDFF #(8) dff03 (twos_complemented_exponent2, clk, 1'b1, T1);

	eight_bit_adder e1(E1, T1, 1'b0, D, cout);
	
	nDFF #(8) dff04 (D, clk, 1'b1, T2);

	wire [23:0] modified_mantissa1, MM1, modified_mantissa2, MM2, shifted_mantissa2, SM2, ones_complemented_mantissa2, TM2;
	wire [31:0] finalmantissa2, FM2, twos_complemented_mantissa2;
	
	modified_mantissa m1(E1, M1, modified_mantissa1);
	modified_mantissa m2(E2, M2, modified_mantissa2);

	barrelRight #(24,5) rs(modified_mantissa2, D, shifted_mantissa2);

	wire sign; 
	sign s1(sign1, sign2, sign);

	ones_complement_mantissa oc1({8'b0, shifted_mantissa2}, sign, finalmantissa2);
	
	nDFF #(32) dff05 (finalmantissa2, clk, 1'b1, FM2);
	
	RecursiveDoubling r0(FM2, {31'b0, sign}, clk, twos_complemented_mantissa2, cout);
	RecursiveDoubling r1({8'b0, modified_mantissa1}, twos_complemented_mantissa2, clk, sum, cout);

	integer i = 0;

	reg [31:0]out;

	always @(sum) begin
		if(sum[24] == 1) begin
            final_mantissa = sum[23:1];
            final_exponent = exponent1 + 1'b1;
        end
        else if(sum[23] == 0) begin
            i = 1;
            while(sum[23 - i] == 1'b0)
            begin
                i = i+1;
            end 
            final_exponent = final_exponent - i;
            temporary = sum[22:0];
            final_mantissa = temporary<<i;
        end
        else begin
            final_mantissa = sum[22:0];
            final_exponent = exponent1;
            final_sign = sign1;
        end
    end
    
	always @ (final_exponent or final_mantissa) begin
		if(&exponent1 == 1'b1 && |mantissa1 == 1'b0)
			out = {sign1,{8{1'b1}},23'b0};
		else if (&exponent1 == 1'b1 && |mantissa1 != 1'b0)
            out = {final_sign, {exponent1, 23'b1}};
		else
			out = {sign1,{8{|sum}} & final_exponent, final_mantissa};
	end

	always #1 clk = ~clk;

	initial begin
		clk = 1'b0;
        #0 operand1 = {1'b0, {8{1'b1}}, 23'b0}; operand2 = {1'b0, {7{1'b1}}, 24'b111011};
        #20 operand1 = {31'b0,1'b1}; operand2 = 32'b00111111110010100011110101110001;
        #20 operand1 = 32'b11000101111110100000000000000000; operand2 = 32'b01000101111110100000000000000000;
        #20 operand1 = {1'b0, {8{1'b1}}, 23'b1}; operand2 = 32'b01000101111110100000000000000000;
        #20
    $finish;
    end
    initial begin
        $monitor($time," a = %b\tb = %b\ts = %b\n",operand1,operand2,out);
	end

endmodule
