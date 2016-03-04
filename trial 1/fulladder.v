`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: 2-bit fulladder 
// Description: 
// Author: Andy Jeong
// Note: in this adder, one is always adding 1 to the previous number
//////////////////////////////////////////////////////////////////////////////////

module fulladder(stat, sum, a);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] a; //input a 2 bit register

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] sum; //output 2 bit registers
output stat; //see whether registers overflown

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] a;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] sum;
wire stat;


wire w0, w1, w2, w3, w_sum0, w_sum1, w_stat;
	
	//set LSB of input to w_sum0
	xor u0(sum[0], a[0], 1'b1);

	//set MSB of input to w_sum1
	and u1(w0, a[0], 1'b1);
	xor u2(w1, a[1], 1'b0);
	and u3(w2, a[1], 1'b0);
	and u4(w3, w0, w1);
	xor u5(sum[1], w0, w1);

	//set carry out to be w_stat
	or  u6(stat, w2, w3);



endmodule