`include "Parallel_Prefix.v"
`include "dFlipFlop.v"

module RecursiveDoubling(input [31:0] a, input [31:0] b, input clk, output [31:0] sum, output cout);
		
	wire [63:0] kgp;
	wire [63:0] temp1;
	wire [63:0] temp2;
	wire [63:0] temp3;
	wire [63:0] temp4;
	wire [63:0] temp5;
		
	wire[31:0] final_cin;
	wire[63:0] Q0, Q1, Q2, Q3, Q4;
		
	genvar i;
	
	//kgp -- 00 -> kill
	//kgp -- 01 -> generate
	//kgp -- 11 -> propogate
		
	//kgp generation
	for(i=0; i<=31; i = i+1) begin
		assign kgp[2*i] = a[i];
		assign kgp[2*i + 1] = |b[i];
	end
	
	//kgp reduction
	// 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
	// 1 - 31.30  30.29  29.28  28.27  27.26  26.25  25.24  24.23  23.22  22.21  21.20  20.19  19.18  18.17  17.16  16.15  15.14  14.13  13.12  12.11  11.10  10.9  9.8  8.7  7.6  6.5  5.4  4.3  3.2  2.1  1.0  0
	Parallel_Prefix mod0(kgp[1:0], 2'b00, temp1[1:0]);
	Parallel_Prefix mod1(kgp[3:2], temp1[1:0], temp1[3:2]);
	Parallel_Prefix mod2(kgp[5:4], temp1[3:2], temp1[5:4]);
	Parallel_Prefix mod3(kgp[7:6], temp1[5:4], temp1[7:6]);
	Parallel_Prefix mod4(kgp[9:8], temp1[7:6], temp1[9:8]);
	Parallel_Prefix mod5(kgp[11:10], temp1[9:8], temp1[11:10]);
	Parallel_Prefix mod6(kgp[13:12], temp1[11:10], temp1[13:12]);
	Parallel_Prefix mod7(kgp[15:14], temp1[13:12], temp1[15:14]);
	Parallel_Prefix mod8(kgp[17:16], temp1[15:14], temp1[17:16]);
	Parallel_Prefix mod9(kgp[19:18], temp1[17:16], temp1[19:18]);
	Parallel_Prefix mod10(kgp[21:20], temp1[19:18], temp1[21:20]);
	Parallel_Prefix mod11(kgp[23:22], temp1[21:20], temp1[23:22]);
	Parallel_Prefix mod12(kgp[25:24], temp1[23:22], temp1[25:24]);
	Parallel_Prefix mod13(kgp[27:26], temp1[25:24], temp1[27:26]);
	Parallel_Prefix mod14(kgp[29:28], temp1[27:26], temp1[29:28]);
	Parallel_Prefix mod15(kgp[31:30], temp1[29:28], temp1[31:30]);
	Parallel_Prefix mod16(kgp[33:32], temp1[31:30], temp1[33:32]);
	Parallel_Prefix mod17(kgp[35:34], temp1[33:32], temp1[35:34]);
	Parallel_Prefix mod18(kgp[37:36], temp1[35:34], temp1[37:36]);
	Parallel_Prefix mod19(kgp[39:38], temp1[37:36], temp1[39:38]);
	Parallel_Prefix mod20(kgp[41:40], temp1[39:38], temp1[41:40]);
	Parallel_Prefix mod21(kgp[43:42], temp1[41:40], temp1[43:42]);
	Parallel_Prefix mod22(kgp[45:44], temp1[43:42], temp1[45:44]);
	Parallel_Prefix mod23(kgp[47:46], temp1[45:44], temp1[47:46]);
	Parallel_Prefix mod24(kgp[49:48], temp1[47:46], temp1[49:48]);
	Parallel_Prefix mod25(kgp[51:50], temp1[49:48], temp1[51:50]);
	Parallel_Prefix mod26(kgp[53:52], temp1[51:50], temp1[53:52]);
	Parallel_Prefix mod27(kgp[55:54], temp1[53:52], temp1[55:54]);
	Parallel_Prefix mod28(kgp[57:56], temp1[55:54], temp1[57:56]);
	Parallel_Prefix mod29(kgp[59:58], temp1[57:56], temp1[59:58]);
	Parallel_Prefix mod30(kgp[61:60], temp1[59:58], temp1[61:60]);
	Parallel_Prefix mod31(kgp[63:62], temp1[61:60], temp1[63:62]);

	nDFF #(64) ddf_01 (temp1, clk, 1'b1, Q0);

	// 2 - 31.29  30.28  29.27  28.26  27.25  26.24  25.23  24.22  23.21  22.20  21.19  20.18  19.17  18.16  17.15  16.14  15.13  14.12  13.11  12.10  11.9  10.8  9.7  8.6  7.5  6.4  5.3  4.2  3.1  2.0  1  0
	Parallel_Prefix mod32(Q0[1:0], 2'b00, temp2[1:0]);
	Parallel_Prefix mod33(Q0[3:2], 2'b00, temp2[3:2]);
	Parallel_Prefix mod34(Q0[5:4], temp2[3:2], temp2[5:4]);
	Parallel_Prefix mod35(Q0[7:6], temp2[5:4], temp2[7:6]);
	Parallel_Prefix mod36(Q0[9:8], temp2[7:6], temp2[9:8]);
	Parallel_Prefix mod37(Q0[11:10], temp2[9:8], temp2[11:10]);
	Parallel_Prefix mod38(Q0[13:12], temp2[11:10], temp2[13:12]);
	Parallel_Prefix mod39(Q0[15:14], temp2[13:12], temp2[15:14]);
	Parallel_Prefix mod40(Q0[17:16], temp2[15:14], temp2[17:16]);
	Parallel_Prefix mod41(Q0[19:18], temp2[17:16], temp2[19:18]);
	Parallel_Prefix mod42(Q0[21:20], temp2[19:18], temp2[21:20]);
	Parallel_Prefix mod43(Q0[23:22], temp2[21:20], temp2[23:22]);
	Parallel_Prefix mod44(Q0[25:24], temp2[23:22], temp2[25:24]);
	Parallel_Prefix mod45(Q0[27:26], temp2[25:24], temp2[27:26]);
	Parallel_Prefix mod46(Q0[29:28], temp2[27:26], temp2[29:28]);
	Parallel_Prefix mod47(Q0[31:30], temp2[29:28], temp2[31:30]);
	Parallel_Prefix mod48(Q0[33:32], temp2[31:30], temp2[33:32]);
	Parallel_Prefix mod49(Q0[35:34], temp2[33:32], temp2[35:34]);
	Parallel_Prefix mod50(Q0[37:36], temp2[35:34], temp2[37:36]);
	Parallel_Prefix mod51(Q0[39:38], temp2[37:36], temp2[39:38]);
	Parallel_Prefix mod52(Q0[41:40], temp2[39:38], temp2[41:40]);
	Parallel_Prefix mod53(Q0[43:42], temp2[41:40], temp2[43:42]);
	Parallel_Prefix mod54(Q0[45:44], temp2[43:42], temp2[45:44]);
	Parallel_Prefix mod55(Q0[47:46], temp2[45:44], temp2[47:46]);
	Parallel_Prefix mod56(Q0[49:48], temp2[47:46], temp2[49:48]);
	Parallel_Prefix mod57(Q0[51:50], temp2[49:48], temp2[51:50]);
	Parallel_Prefix mod58(Q0[53:52], temp2[51:50], temp2[53:52]);
	Parallel_Prefix mod59(Q0[55:54], temp2[53:52], temp2[55:54]);
	Parallel_Prefix mod60(Q0[57:56], temp2[55:54], temp2[57:56]);
	Parallel_Prefix mod61(Q0[59:58], temp2[57:56], temp2[59:58]);
	Parallel_Prefix mod62(Q0[61:60], temp2[59:58], temp2[61:60]);
	Parallel_Prefix mod63(Q0[63:62], temp2[61:60], temp2[63:62]);

	nDFF #(64) ddf_02 (temp2, clk, 1'b1, Q1);

	// 4 - 31.27  30.26  29.25  28.24  27.23  26.22  25.21  24.20  23.19  22.18  21.17  20.16  19.15  18.14  17.13  16.12  15.11  14.10  13.9  12.8  11.7  10.6  9.5  8.4  7.3  6.2  5.1  4.0  3  2  1  0
	Parallel_Prefix mod64(Q1[1:0], 2'b00, temp3[1:0]);
	Parallel_Prefix mod65(Q1[3:2], 2'b00, temp3[3:2]);
	Parallel_Prefix mod66(Q1[5:4], 2'b00, temp3[5:4]);
	Parallel_Prefix mod67(Q1[7:6], 2'b00, temp3[7:6]);
	Parallel_Prefix mod68(Q1[9:8], temp3[7:6], temp3[9:8]);
	Parallel_Prefix mod69(Q1[11:10], temp3[9:8], temp3[11:10]);
	Parallel_Prefix mod70(Q1[13:12], temp3[11:10], temp3[13:12]);
	Parallel_Prefix mod71(Q1[15:14], temp3[13:12], temp3[15:14]);
	Parallel_Prefix mod72(Q1[17:16], temp3[15:14], temp3[17:16]);
	Parallel_Prefix mod73(Q1[19:18], temp3[17:16], temp3[19:18]);
	Parallel_Prefix mod74(Q1[21:20], temp3[19:18], temp3[21:20]);
	Parallel_Prefix mod75(Q1[23:22], temp3[21:20], temp3[23:22]);
	Parallel_Prefix mod76(Q1[25:24], temp3[23:22], temp3[25:24]);
	Parallel_Prefix mod77(Q1[27:26], temp3[25:24], temp3[27:26]);
	Parallel_Prefix mod78(Q1[29:28], temp3[27:26], temp3[29:28]);
	Parallel_Prefix mod79(Q1[31:30], temp3[29:28], temp3[31:30]);
	Parallel_Prefix mod80(Q1[33:32], temp3[31:30], temp3[33:32]);
	Parallel_Prefix mod81(Q1[35:34], temp3[33:32], temp3[35:34]);
	Parallel_Prefix mod82(Q1[37:36], temp3[35:34], temp3[37:36]);
	Parallel_Prefix mod83(Q1[39:38], temp3[37:36], temp3[39:38]);
	Parallel_Prefix mod84(Q1[41:40], temp3[39:38], temp3[41:40]);
	Parallel_Prefix mod85(Q1[43:42], temp3[41:40], temp3[43:42]);
	Parallel_Prefix mod86(Q1[45:44], temp3[43:42], temp3[45:44]);
	Parallel_Prefix mod87(Q1[47:46], temp3[45:44], temp3[47:46]);
	Parallel_Prefix mod88(Q1[49:48], temp3[47:46], temp3[49:48]);
	Parallel_Prefix mod89(Q1[51:50], temp3[49:48], temp3[51:50]);
	Parallel_Prefix mod90(Q1[53:52], temp3[51:50], temp3[53:52]);
	Parallel_Prefix mod91(Q1[55:54], temp3[53:52], temp3[55:54]);
	Parallel_Prefix mod92(Q1[57:56], temp3[55:54], temp3[57:56]);
	Parallel_Prefix mod93(Q1[59:58], temp3[57:56], temp3[59:58]);
	Parallel_Prefix mod94(Q1[61:60], temp3[59:58], temp3[61:60]);
	Parallel_Prefix mod95(Q1[63:62], temp3[61:60], temp3[63:62]);

	nDFF #(64) ddf_03 (temp3, clk, 1'b1, Q2);

    	// 8 - 31.23  30.22  29.21  28.20  27.19  26.18  25.17  24.16  23.15  22.14  21.13  20.12  19.11  18.10  17.9  16.8  15.7  14.6  13.5  12.5  11.3  10.2  9.1  8.0  7  6  5  4  3  2  1  0
	Parallel_Prefix mod96(Q2[3:2], 2'b00, temp4[3:2]);
	Parallel_Prefix mod97(Q2[3:2], 2'b00, temp4[3:2]);
	Parallel_Prefix mod98(Q2[5:4], 2'b00, temp4[5:4]);
	Parallel_Prefix mod99(Q2[7:6], 2'b00, temp4[7:6]);
	Parallel_Prefix mod100(Q2[9:8], 2'b00, temp4[9:8]);
	Parallel_Prefix mod101(Q2[11:10], 2'b00, temp4[11:10]);
	Parallel_Prefix mod102(Q2[13:12], 2'b00, temp4[13:12]);
	Parallel_Prefix mod103(Q2[15:14], 2'b00, temp4[15:14]);
	Parallel_Prefix mod104(Q2[17:16], temp4[15:14], temp4[17:16]);
	Parallel_Prefix mod105(Q2[19:18], temp4[17:16], temp4[19:18]);
	Parallel_Prefix mod106(Q2[21:20], temp4[19:18], temp4[21:20]);
	Parallel_Prefix mod107(Q2[23:22], temp4[21:20], temp4[23:22]);
	Parallel_Prefix mod108(Q2[25:24], temp4[23:22], temp4[25:24]);
	Parallel_Prefix mod109(Q2[27:26], temp4[25:24], temp4[27:26]);
	Parallel_Prefix mod110(Q2[29:28], temp4[27:26], temp4[29:28]);
	Parallel_Prefix mod111(Q2[31:30], temp4[29:28], temp4[31:30]);
	Parallel_Prefix mod112(Q2[33:32], temp4[31:30], temp4[33:32]);
	Parallel_Prefix mod113(Q2[35:34], temp4[33:32], temp4[35:34]);
	Parallel_Prefix mod114(Q2[37:36], temp4[35:34], temp4[37:36]);
	Parallel_Prefix mod115(Q2[39:38], temp4[37:36], temp4[39:38]);
	Parallel_Prefix mod116(Q2[41:40], temp4[39:38], temp4[41:40]);
	Parallel_Prefix mod117(Q2[43:42], temp4[41:40], temp4[43:42]);
	Parallel_Prefix mod118(Q2[45:44], temp4[43:42], temp4[45:44]);
	Parallel_Prefix mod119(Q2[47:46], temp4[45:44], temp4[47:46]);
	Parallel_Prefix mod120(Q2[49:48], temp4[47:46], temp4[49:48]);
	Parallel_Prefix mod121(Q2[51:50], temp4[49:48], temp4[51:50]);
	Parallel_Prefix mod122(Q2[53:52], temp4[51:50], temp4[53:52]);
	Parallel_Prefix mod123(Q2[55:54], temp4[53:52], temp4[55:54]);
	Parallel_Prefix mod124(Q2[57:56], temp4[55:54], temp4[57:56]);
	Parallel_Prefix mod125(Q2[59:58], temp4[57:56], temp4[59:58]);
	Parallel_Prefix mod126(Q2[61:60], temp4[59:58], temp4[61:60]);
	Parallel_Prefix mod127(Q2[63:62], temp4[61:60], temp4[63:62]);

	nDFF #(64) ddf_04 (temp4, clk, 1'b1, Q3);
	
	// 16 - 31.15  30.14  29.13  28.12  27.11  26.10  25.9  24.8  23.7  22.6  21.5  20.4  19.3  18.2  17.1  16.0  15  14  13  12  11  10  9  8  7  6  5  4  3  2  1  0
	Parallel_Prefix mod128(Q3[1:0], 2'b00, temp5[1:0]);
	Parallel_Prefix mod129(Q3[3:2], 2'b00, temp5[3:2]);
	Parallel_Prefix mod130(Q3[5:4], 2'b00, temp5[5:4]);
	Parallel_Prefix mod131(Q3[7:6], 2'b00, temp5[7:6]);
	Parallel_Prefix mod132(Q3[9:8], 2'b00, temp5[9:8]);
	Parallel_Prefix mod133(Q3[11:10], 2'b00, temp5[11:10]);
	Parallel_Prefix mod134(Q3[13:12], 2'b00, temp5[13:12]);
	Parallel_Prefix mod135(Q3[15:14], 2'b00, temp5[15:14]);
	Parallel_Prefix mod136(Q3[17:16], 2'b00, temp5[17:16]);
	Parallel_Prefix mod137(Q3[19:18], 2'b00, temp5[19:18]);
	Parallel_Prefix mod138(Q3[21:20], 2'b00, temp5[21:20]);
	Parallel_Prefix mod139(Q3[23:22], 2'b00, temp5[23:22]);
	Parallel_Prefix mod140(Q3[25:24], 2'b00, temp5[25:24]);
	Parallel_Prefix mod141(Q3[27:26], 2'b00, temp5[27:26]);
	Parallel_Prefix mod142(Q3[29:28], 2'b00, temp5[29:28]);
	Parallel_Prefix mod143(Q3[31:30], 2'b00, temp5[31:30]);
	Parallel_Prefix mod144(Q3[33:32], temp5[31:30], temp5[33:32]);
	Parallel_Prefix mod145(Q3[35:34], temp5[33:32], temp5[35:34]);
	Parallel_Prefix mod146(Q3[37:36], temp5[35:34], temp5[37:36]);
	Parallel_Prefix mod147(Q3[39:38], temp5[37:36], temp5[39:38]);
	Parallel_Prefix mod148(Q3[41:40], temp5[39:38], temp5[41:40]);
	Parallel_Prefix mod149(Q3[43:42], temp5[41:40], temp5[43:42]);
	Parallel_Prefix mod150(Q3[45:44], temp5[43:42], temp5[45:44]);
	Parallel_Prefix mod151(Q3[47:46], temp5[45:44], temp5[47:46]);
	Parallel_Prefix mod152(Q3[49:48], temp5[47:46], temp5[49:48]);
	Parallel_Prefix mod153(Q3[51:50], temp5[49:48], temp5[51:50]);
	Parallel_Prefix mod154(Q3[53:52], temp5[51:50], temp5[53:52]);
	Parallel_Prefix mod155(Q3[55:54], temp5[53:52], temp5[55:54]);
	Parallel_Prefix mod156(Q3[57:56], temp5[55:54], temp5[57:56]);
	Parallel_Prefix mod157(Q3[59:58], temp5[57:56], temp5[59:58]);
	Parallel_Prefix mod158(Q3[61:60], temp5[59:58], temp5[61:60]);
	Parallel_Prefix mod159(Q3[63:62], temp5[61:60], temp5[63:62]);

	nDFF #(64) ddf_05 (temp5, clk, 1'b1, Q4);

	//32 - NIL
	
	//final input carry calculation
	for(i=0; i<=31; i = i+1)
	begin
		assign final_cin[i] = Q4[2*i + 1];
	end
	
	//calculating sum
	assign sum[0] = a[0] ^ b[0];
	for(i=1; i<=31; i = i+1)
	begin
		assign sum[i] = a[i] ^ b[i] ^ final_cin[i-1];
	end
	
	assign cout = final_cin[31];
	
endmodule
