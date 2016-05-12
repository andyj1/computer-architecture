//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ALU(zero, in);

//-------------Input Ports-----------------------------
input wire [7:0] in;
//-------------Output Ports----------------------------
output reg zero; 	

//------------------Instructions-----------------------

always @(in)
begin
	if (in == 8'b11111111) begin
		zero = 0;
	end else begin
		zero = 1;
	end
end


endmodule
