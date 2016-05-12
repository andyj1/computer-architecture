//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module memory(instructions, readData, pc, memWrite, memRead, input_addr, dataMemWrite);

//fetch
input wire [7:0] pc;
output reg [7:0] instructions;

//store
input wire memWrite, memRead;
input wire [7:0] input_addr;	//address of memory where dataMemWrite will be written onto
input wire [7:0] dataMemWrite;	//data to be written onto memory
output reg [7:0] readData;		//data of the memory at the specified address

reg [7:0] MDR [0:255];		//8 bit wide, 256 address deep register memory

initial 
	begin
		$readmemb("output.bin", MDR); 
		readData = 0;
	end
always @*
	begin
		instructions  = MDR[pc];
		if (memRead == 1) begin
			$display("instructions: %b", instructions);
			readData = MDR[input_addr]; //load word at the specified address
			$display("--Memory Reading-- at address: %b : data: %d ",input_addr, readData);
		end if (memWrite == 1) begin
			$display("instructions: %b", instructions);
			MDR[input_addr] = dataMemWrite;
			$display("--Memory Writing-- at address: %b : data: %d ", input_addr, MDR[input_addr]);
		end
	end
endmodule
