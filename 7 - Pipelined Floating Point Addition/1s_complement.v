module ones_complement (i, j);

input [7:0] i;
output [7:0] j; 

not not_0 (j[0], i[0]);
not not_1 (j[1], i[1]);
not not_2 (j[2], i[2]);
not not_3 (j[3], i[3]);
not not_4 (j[4], i[4]);
not not_5 (j[5], i[5]);
not not_6 (j[6], i[6]);
not not_7 (j[7], i[7]);
/*not not_8 (j[8], i[8]);
not not_9 (j[9], i[9]);
not not_10 (j[10], i[10]);
not not_11 (j[11], i[11]);
not not_12 (j[12], i[12]);
not not_13 (j[13], i[13]);
not not_14 (j[14], i[14]);
not not_15 (j[15], i[15]);
not not_16 (j[16], i[16]);
not not_17 (j[17], i[17]);
not not_18 (j[18], i[18]);
not not_19 (j[19], i[19]);
not not_20 (j[20], i[20]);
not not_21 (j[21], i[21]);
not not_22 (j[22], i[22]);
not not_23 (j[23], i[23]);
not not_24 (j[24], i[24]);
not not_25 (j[25], i[25]);
not not_26 (j[26], i[26]);
not not_27 (j[27], i[27]);
not not_28 (j[28], i[28]);
not not_29 (j[29], i[29]);
not not_30 (j[30], i[30]);
not not_31 (j[31], i[31]);*/

endmodule
