//////////////////////////////////////////////////////////////////////////////////
// Module Name: halt.v
// Description: takes clock input and according to the current instruction it 
// determines if the clock should go on or not
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module halt(pulse, clk, instruction_from_jno);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [1:0] instruction_from_jno; 	//input a 2 bit register from JNO
input clk;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output pulse;

wire [1:0] instruct;
wire clk;
wire pulses;
wire [1:0] w;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

and a1(w[1], instruction_from_jno[1], !instruction_from_jno[0]);
not n1(w[0], w[1]);
and(pulse, clk, w[0]);

endmodule