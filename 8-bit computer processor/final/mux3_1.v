//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module mux3_1(output1, input0, input1, input2, ctrl);

//-------------Input Ports-----------------------------
input wire [1:0] ctrl;		
input wire [7:0] input0;	//input at 0
input wire [7:0] input1;	//input at 1
input wire [7:0] input2;	//input at 2

//-------------Output Ports----------------------------

output reg [7:0] output1; 	//8 bits of output

//------------------Instructions-----------------------
always @*
	begin
		case(ctrl)
		2'b00:
			output1 = input0;
		2'b01:
			output1 = input1;
		2'b10:
			output1 = input2;
		endcase
	end
endmodule