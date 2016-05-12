//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module mux2_1_ctrl1_in2(output1, input0, input1, ctrl);

//-------------Input Ports-----------------------------
input wire ctrl;		
input wire [7:0] input0;	//input at 0
input wire [7:0] input1;	//unput at 1

//-------------Output Ports----------------------------

output reg [7:0] output1; 	

//------------------Instructions-----------------------
always @*
	begin
		if (ctrl == 1'b0)
			output1 = input0;
		if (ctrl == 1'b1)
			output1 = input1;
	end
endmodule
