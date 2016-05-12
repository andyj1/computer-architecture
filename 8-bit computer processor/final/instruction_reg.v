//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module instruction_reg (j_immediate, jump_opcode_check, instruction_to_control_unit, rt, rs, i_immediate, funct, instruction_input);
//-------------Input-------------------
input wire [7:0] instruction_input;
//-------------Output------------------
output reg [4:0] j_immediate;
output reg [1:0] jump_opcode_check;
output reg [2:0] instruction_to_control_unit;
output reg [1:0] rt;
output reg [1:0] rs;
output reg [1:0] i_immediate;
output reg funct;

//------------------Instructions-----------------------
initial 
	begin
		j_immediate <= 8'b0;
		jump_opcode_check <= 2'b0;
		funct <= 1'b0;
		instruction_to_control_unit <= 3'b0;
		rt <= 2'b0;
		rs <= 2'b0;
		i_immediate <= 2'b0;
	end

always @(instruction_input)
	begin
		j_immediate <= instruction_input[4:0];
		jump_opcode_check <= instruction_input[7:6];
		funct <= instruction_input[4];
		instruction_to_control_unit <= instruction_input[7:5];
		rt <= instruction_input [3:2];
		rs <= instruction_input [1:0];
		i_immediate <= instruction_input [3:2];
	end

endmodule
