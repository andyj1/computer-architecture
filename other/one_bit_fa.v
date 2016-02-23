<<<<<<< HEAD
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: 1-bit fulladder 
// Description: 
// Author: Andy Jeong
//////////////////////////////////////////////////////////////////////////////////

module fulladder(c_out, sum, a, b, c_in);
output c_out, sum;
input a,b,c_in;
wire w0, w1, w2;

	xor u0(sum, a, b, c_in);
	and u1(w0, a, b);
	and u2(w1, b, c_in);
	and u3(w2, c_in, b);
	or  u4(c_out, w0, w1, w2)
endmodule
=======
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: 1-bit fulladder 
// Description: 
// Author: Andy Jeong
//////////////////////////////////////////////////////////////////////////////////

module fulladder(c_out, sum, a, b, c_in);
output c_out, sum;
input a,b,c_in;
wire w0, w1, w2;

	xor u0(sum, a, b, c_in);
	and u1(w0, a, b);
	and u2(w1, b, c_in);
	and u3(w2, c_in, b);
	or  u4(c_out, w0, w1, w2)
endmodule
>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
