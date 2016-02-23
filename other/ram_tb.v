<<<<<<< HEAD
module ram_tb();
reg clk, a_1, a_0;
wire o_1;
wire o_0;

initial begin

	$monitor ( "time = %g clk =%g o1 = %b o0 = %b",
			   $time, clk, o_1, o_0);

	clk = 0;

	//a_1, a_0 values inputed by delay for testing the output o1, o0
	a_1 = 1'b0;
	a_0 = 1'b0;
	#1

	a_0 = 1'b1;
	a_1 = 1'b0;
	#1;

	a_0 = 1'b0;
	a_1 = 1'b1;
	#1;

	a_0 = 1'b1;
	a_1 = 1'b1; 
	

	$finish;
end

always 
	#1 clk = ~clk;

ram ram0( a_1,a_0, o_1, o_0 );

endmodule

module ram(a1, a0, o1, o0);

input a1;
input a0;
output o1;
output o0;
wire [2:0] w;

// o1
and a1(o1, a1, a0);

//o0
and a2(o0, ~a1, a0);

=======
module ram_tb();
reg clk, a_1, a_0;
wire o_1;
wire o_0;

initial begin

	$monitor ( "time = %g clk =%g o1 = %b o0 = %b",
			   $time, clk, o_1, o_0);

	clk = 0;

	//a_1, a_0 values inputed by delay for testing the output o1, o0
	a_1 = 1'b0;
	a_0 = 1'b0;
	#1

	a_0 = 1'b1;
	a_1 = 1'b0;
	#1;

	a_0 = 1'b0;
	a_1 = 1'b1;
	#1;

	a_0 = 1'b1;
	a_1 = 1'b1; 
	

	$finish;
end

always 
	#1 clk = ~clk;

ram ram0( a_1,a_0, o_1, o_0 );

endmodule

module ram(a1, a0, o1, o0);

input a1;
input a0;
output o1;
output o0;
wire [2:0] w;

// o1
and a1(o1, a1, a0);

//o0
and a2(o0, ~a1, a0);

>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
endmodule