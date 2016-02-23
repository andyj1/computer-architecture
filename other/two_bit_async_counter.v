`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Asynchronous counter 
// Description: 
// Author: Andy Jeong
//////////////////////////////////////////////////////////////////////////////////

module counter(clk, count);
input clk;
output[3:0] count;
reg[3:0] count;
wire clk;

	initial
	    count = 4'b0;

	always @ ( negedge clk )
	    count[0] <= ~count[0];

	always @ ( negedge count[0] )
	    count[1] <= ~count[1];

	always @ ( negedge count[1] )
	    count[2] <= ~count[2];

	always @ ( negedge count[2] )
	    count[3] <= ~count[3];

endmodule