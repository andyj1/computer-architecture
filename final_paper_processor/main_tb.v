//
// School: The Cooper Union
// Course: ECE151A Spring 2016
// Assignment: Paper Processor 
// Group members: Andy Jeong, Brenda So, Gordon Macshane
// Date: 2/22/2016
//
//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
//	Instructions Guide:
//		INC: 00(2)
//		JNO: 01(2)
//		HLT: 10(2)
//
//	Instructions for the 2-bit paper processor:
//		IS1: 	INC
//		IS2,3:  JNO 00(2)
//		IS4: 	HLT
//
`timescale 1ns/1ns

`include "memory.v"
`include "increment.v"
`include "programcounter.v"
`include "halt.v"
`include "jno.v"
`include "checking.v"
`include "dff_reset_negedge.v"
`include "dff_reset_posedge.v"

module main_tb(); 

reg reg_status; 						// status register
reg reg_clock; 							// clock register
reg [1:0] reg_reset;					//used to initialize the program counter
reg [1:0] reg_output; 						// output registers

wire wire_clock_from_jno;			//Pulse from JNO, imitating monostable timer
wire [1:0] wire_adder_to_output; 			// INC logic :connect adder to reg out
wire wire_adder_to_status;					// ING logic: ddding to status
wire [1:0] wire_instruction_from_memory; 				// output instruction from ram
wire [1:0] wire_instruction_checked;				// actual instruction after checking
wire wire_monostable_clock;			// monostable clock induced by inc logic
wire wire_clock_from_halt;							// clock induced by halt
wire wire_monostable_clock_status_0;
wire wire_enabled;
wire wire_enabled_status;
wire [1:0] wire_program_counter;					// Counter: program counter output

initial begin

	//print out on console
	$monitor ("PC = %b instr = %b reg = %b status = %b",  wire_program_counter, wire_instruction_from_memory, reg_output, reg_status);

	reg_clock = 0; 				// initialize clock to be 0
	reg_status = 0; 			// initialize status to be 0
	reg_output= 2'b00; 			// initialize value register
	reg_reset= 2'b00;			// Resettting logic
	#1 reg_reset = 2'b11;		//Resetting program counter
	#1 reg_reset= 2'b00;
	#80 $finish; 				//simulation runs for 80 seconds
end

initial begin
	$dumpfile ("pp.vcd");    //waveform file output in .vcd format
    $dumpvars;
end

always @(posedge wire_monostable_clock_status_0)
begin
	reg_output[0] <= wire_adder_to_output[0];
	reg_output[1] <= wire_adder_to_output[1];
	reg_status <= wire_adder_to_status;
end

always 
	#4 reg_clock = ~reg_clock; // Generate clock

memory memory0(wire_program_counter,wire_instruction_from_memory); 												
programcounter pc0(wire_program_counter, wire_clock_from_jno, reg_reset, wire_instruction_from_memory, wire_clock_from_halt, wire_enabled_status); 

and a1(wire_monostable_clock_status_0, wire_monostable_clock, !reg_status);		

checking checking0(wire_instruction_checked, wire_enabled, wire_instruction_from_memory);					
increment increment0(wire_adder_to_output, wire_adder_to_status,wire_monostable_clock,wire_clock_from_halt,  reg_output,wire_instruction_checked);

jno jno0(wire_enabled, wire_enabled_status, wire_clock_from_jno, reg_status, wire_instruction_checked, wire_clock_from_halt);		

halt halt0(wire_clock_from_halt, reg_clock, wire_instruction_checked);								
endmodule

