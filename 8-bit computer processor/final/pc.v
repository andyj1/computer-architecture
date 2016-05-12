
//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module pc(output1, clk, input1, reset, pc);

//-------------Input Ports-----------------------------
input wire clk;
input wire [7:0] input1;
input wire reset;
input [7:0] pc;

//-------------Output Ports----------------------------
output reg [7:0] output1; 	//8 bits of output

//------------------Instructions-----------------------

initial begin
	output1 <= 8'b00000000;
end

always @(posedge clk) begin
	if (reset == 1) begin
		#1 output1 = 8'b00000000;
	end if (pc == 8'b00000000) begin
		$finish;
	end
	else begin
		#1 output1 <= input1;
	end
end

always @(reset) begin
	output1 = 8'b00000000;
end
endmodule
