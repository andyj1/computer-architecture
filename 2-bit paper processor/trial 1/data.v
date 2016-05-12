module data(clk, d1, d0, data1, data0, a1, a0, s);
	input clk, data1, data0, a1, a0, s;
	output d1, d0;
	wire [8:0] w;

	and a1(w[0], data1, a1);
	and a2(w[1], s, data0, ~a1);
	and a3(w[2], ~data1, ~a1, a0);
	and a4(w[3], ~s, a1, ~a0);
	and a5(w[4], ~data0, a1, ~a1);

	or o1(d1, w[0], w[1], w[2], w[3], w[4]);

	and a6(w[5], data1, a0);
	and a7(w[6], ~s, ~data0, ~a0);
	and a8(w[7], ~data1, ~data0, ~a0);
	and a9(w[8], s, data0, ~a0);

	or o2(d0, w[5], w[6], w[7], w[8]);

endmodule