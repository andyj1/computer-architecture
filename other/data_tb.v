<<<<<<< HEAD
`timescale 1ps/1ps
module data_tb();

reg clk, data_1, data_0, a1, a0, s;
wire d1, d0;

initial begin
	$monitor ("time=%t,clk=%t, s = %b, data_1 = %b, data_0 = %b, a1 = %b, a0 = %b, d1 = %b, d0 = %b",$time,clk,s,data_1,data_0,a1,a0,d1,d0);

	clk = 0; a0 = 1'b0; a1 = 1'b0;
	data_0 = 1'b0; data_1 = 1'b0; s = 1'b0;
	$dumpfile ("data.vcd"); 
	$dumpvars;
	#1 clk = ~clk;
    #32 $finish;
end

always @( clk) fork
	
	#16 s = ~s;
	#8 data_1 = ~data_1;  
	#4 data_0 = ~data_0; 
	#2 a1 = ~a1;
	#1 a0 = ~a0;
join

data data0(clk, d1, d0, data_1,data_0,a1,a0, s);

endmodule

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

=======
`timescale 1ps/1ps
module data_tb();

reg clk, data_1, data_0, a1, a0, s;
wire d1, d0;

initial begin
	$monitor ("time=%t,clk=%t, s = %b, data_1 = %b, data_0 = %b, a1 = %b, a0 = %b, d1 = %b, d0 = %b",$time,clk,s,data_1,data_0,a1,a0,d1,d0);

	clk = 0; a0 = 1'b0; a1 = 1'b0;
	data_0 = 1'b0; data_1 = 1'b0; s = 1'b0;
	$dumpfile ("data.vcd"); 
	$dumpvars;
	#1 clk = ~clk;
    #32 $finish;
end

always @( clk) fork
	
	#16 s = ~s;
	#8 data_1 = ~data_1;  
	#4 data_0 = ~data_0; 
	#2 a1 = ~a1;
	#1 a0 = ~a0;
join

data data0(clk, d1, d0, data_1,data_0,a1,a0, s);

endmodule

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

>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
endmodule