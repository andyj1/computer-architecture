//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module mux2_1_ctrl3(output1, input0, input1, ctrl);

//-------------Input Ports-----------------------------
input wire [2:0] ctrl;		//3 bit control
input wire [7:0] input0;	//input at 0
input wire [7:0] input1;	//input at 1

//-------------Output Ports----------------------------

output reg [7:0] output1; 	//8 bits of output

//------------------Instructions-----------------------
//ctrl = ALUsrc (1 iff I type instruction)

always @(input0||input1)
	begin
		if (ctrl == 0)
			output1 = input0;
		if (ctrl == 1)
			output1 = input1;
	end

endmodule