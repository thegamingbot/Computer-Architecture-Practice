`include "fullAdderGate.v"

module eight_bit_adder (a, b, cin, sum, ca);
input [7:0] a, b;
input cin;

output [7:0] sum;
output ca;

wire c1, c2, c3, c4, c5, c6, c7;

fullAdder FA_0 (a[0], b[0], cin, sum[0], c1);
fullAdder FA_1 (a[1], b[1], c1, sum[1], c2);
fullAdder FA_2 (a[2], b[2], c2, sum[2], c3);
fullAdder FA_3 (a[3], b[3], c3, sum[3], c4);
fullAdder FA_4 (a[4], b[4], c4, sum[4], c5);
fullAdder FA_5 (a[5], b[5], c5, sum[5], c6);
fullAdder FA_6 (a[6], b[6], c6, sum[6], c7);
fullAdder FA_7 (a[7], b[7], c7, sum[7], ca);


endmodule

