/*
// School: The Cooper Union
// Course: ECE151A Spring 2016
// Assignment: Paper Processor
// Group members: Andy Jeong, Brenda So, Gordon Macshane
// Date: 2/22/2016
//
//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
//	Instructions:
//		INC: 00(2)
//		JNO: 01(2)
//		HLT: 10(2)
//
//	Instructions for the 2-bit paper processor:
//			IS1: 	INC
//			IS2,3:  JNO 00(2)
//			IS4: 	HLT
*/
`include "counter.v"
`include "ram.v"
`include "setAddress.v"
`include "register.v"
`timescale 1ns/1ns

//-------testbench for paper-processor
// See below for the implemented modules

module paperprocessor();

reg clk;                         //clock
reg status;                      //status
wire [1:0] a;                    //address
wire [1:0] data;                 //data
wire [1:0] count;                //counter
wire [1:0] register;             //register values
reg reset;                       //reset


initial fork                     //initialization run in parallel 
	  clk = 0;	
		reset = 1;
		status = 0;
		$monitor ( "clk =%g s = %b addr=%b%b reg = %b data = %b%b", 
              clk, status,  a[1], a[0], register, data[1], data[0]);
		#20 status = ~status;
		#22 $finish;   
join

initial begin
	   $dumpfile ("paper.vcd");    //waveform file in .vcd format
     $dumpvars;
end

always begin                     //clock toggle
	#1 clk = ~clk;
end

counter counter0(count, clk, reset);
register register0(clk, status, count, register);
setAddress setaddress0(a, status, count); 
ram ram0(a, data);

endmodule

