module jk(clk, reset, q);
	input clk;
	input reset;
	output [1:0] d;
	wire [1:0] q;
	wire [1:0] d;

	dff dff0(clk, reset, q[0], d[0]);
	adder add(d[0], ~q[0], q[1]);
endmodule

module dff(clk, reset, q, d);
	input clk, reset;
	output q, d;
	wire q, d;

	and a0(q, d, reset, clk);
	not n0(d, d);
	xor xor0(q, d, 1'b0);
endmodule

module adder(in1, in2, out);
	input in1, in2;
	output out;
	wire out;

	xor(out, in1, in2);
	and(carry, in1, in2);

endmodule

module counter_tb();
	reg clk, reset;
	wir
