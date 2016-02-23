//////////////////////////////////////////////////////////////////////////////////
// Module Name: dff.v
// Description: D flip flop that sets and resets at negedge
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module dff (clk, s, r, d, q, qbar);
	input clk, s, r, d;
	output q,qbar;
	reg q,qbar;
	always @(negedge r) begin
		q = 1'b0;
		qbar = 1'b1;
		end
	always @(negedge s) begin
		q = 1'b1;
		qbar = 1'b0;
		end
	always @(posedge clk) begin
		#1
		q = d;
		qbar = ~d;
		end

endmodule