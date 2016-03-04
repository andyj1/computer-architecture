//////////////////////////////////////////////////////////////////////////////////
// Module Name: checking.v
// Description: checks if either of two inputs is HIGH at a certain time
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module checking(instruct_checked, enabled, instruct_from_jno);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [1:0] instruct_from_jno; 	
input enabled;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [1:0] instruct_checked;

//input and output can be declared again as wires to pass into modules
wire [1:0] instruct;
wire enabled;
wire [1:0] instruct_checked;

or o1(instruct_checked[1], enabled, instruct_from_jno[1]);
or o2(instruct_checked[0], enabled, instruct_from_jno[0]);

endmodule