//////////////////////////////////////////////////////////////////////////////////
// Module Name: halt.v
// Description: takes clock input and according to the current instruction it 
// determines if the clock should go on or not
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module halt(pulses, clk, instruct);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] instruct; 	//input a 2 bit register from JNO
input clk;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output pulses;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] instruct;
wire clk;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire pulses;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−
wire w1;
wire w2;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

and a1(w1, instruct[1], !instruct[0]);
not n1(w2, w1);

and(pulses, clk, w2);

endmodule