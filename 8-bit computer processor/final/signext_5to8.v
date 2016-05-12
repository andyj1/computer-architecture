//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module signext_5to8 (dataout,datain);

//-------------Input Ports-----------------------------
input wire [4:0] datain;	//input 

//-------------Output Ports----------------------------
output reg [7:0] dataout; 	//8 bits of output

//-------------Intermediate Ports Data Type-------------
reg [3:0] sign;

//------------------Instructions-----------------------
always @ datain
	begin
		if (datain >= 5'b10000) begin
			sign = 3'b111;
		end if (datain < 5'b10000) begin
			sign = 3'b000;
		end
		dataout = {sign,datain};
	end
endmodule
