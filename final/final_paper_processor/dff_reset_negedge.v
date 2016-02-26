//////////////////////////////////////////////////////////////////////////////////
// Module Name: dff_reset_negedge.v
// Description: D flip flop that sets and resets at negedge
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module dff_reset_negedge (clk, s, r, d, output_q, output_not_q);
	input clk, s, r, d;
	output output_q, output_not_q;
	reg output_q, output_not_q;
	always @(negedge r) begin
		output_q = 1'b0;
		output_not_q = 1'b1;
		end
	always @(negedge s) begin
		output_q = 1'b1;
		output_not_q = 1'b0;
		end
	always @(posedge clk) begin
		output_q = d;
		output_not_q = ~d;
		end

endmodule