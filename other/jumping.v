`include "jumping.v"
`include "d_flip_flop.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: 2-bit RAM
// Description: 
// Author: Andy Jeong
//////////////////////////////////////////////////////////////////////////////////

module jumping(clk,a0,b0,status, pc0,pc1);
input clk, a0, b0, status;
output pc0, pc1;
reg[1:0] count;

wire w0, w1, w2, w3, w4;

initial
	    count = 2'b0;
begin
	and u0(w0, !status, !a0, b0);
	d_flip_flop out(enable, w0, clk);
	and u1(w1, a0, enable);
	and u2(w2, b0, enable);

			//Program Counter
			@ ( negedge clk )
				    count[0] <= ~count[0];
				@ ( negedge count[0] )
				    count[1] <= ~count[1];
		and u3(w3, count[0], !enable);
		and u4(w4, count[1], !enable);
		or u5(pc0, w3, w1);
		or u6(pc1, w4, w2);
	end
endmodule
