//////////////////////////////////////////////////////////////////////////////////
// Module Name: increment.v
// Description: increments 2-bit value from previous
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

`include "fulladder.v"

module increment(adder_to_output, adder_to_status, output_monostable, output_pulse, out, instruct_checked);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [1:0] instruct_checked; 	//input a 2 bit register from JNO
input [1:0] out;
input output_pulse;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
inout [1:0] adder_to_output;
output adder_to_status;
output output_monostable;

//input and output can be declared again as wires to pass into modules
wire [1:0] instructA;
wire [1:0] out;
wire output_pulse;
wire [1:0] adder_to_output;
wire status;
reg output_monostable;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−
wire w1;

//−−−−−−----−-−−−−−−instructions---−−−−−−−−−−−−−−−--−−−

and (w1, output_pulse, !instruct_checked[1], !instruct_checked[0]);

initial begin
output_monostable = 0;
end

always @(posedge w1)
begin
	output_monostable = 1;
	#2
	output_monostable = 0;
end

fulladder adder(adder_to_status, adder_to_output, out);

endmodule

