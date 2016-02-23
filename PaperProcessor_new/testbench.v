
//////////////////////////////////////////////////////////////////////////////////
// Module Name: 2-bit fulladder 
// Description: This is last updated 2/19/2016 3:11 am. When ran this should 
// print out only the increment logic
// Author: Andy Jeong
// Note: in this adder, one is always adding 1 to the previous number
//////////////////////////////////////////////////////////////////////////////////

`include "twoBitRam.v"
`include "increment.v"
`include "programcounter.v"
`include "halt.v"
`include "jno.v"
`include "checking.v"
`include "dff.v"
`include "dfff.v"

module test_tb(); 

reg status; 						// status register
reg clock; 							// clock register
wire monostable;					// monostable clock induced by inc logic
wire pulse;							// clock induced by halt
wire monostabler;
reg [1:0] out; 						// output registers
wire w3, w4, w5, w6;
wire openpulser;					//Pulse from JNO, imitating monostable timer

reg [1:0] constant; 				// INC logic: add to full adder
wire [1:0] adder_to_out; 			// INC logic :connect adder to reg out
wire adder_to_stat;					// ING logic: ddding to status
wire [1:0] instruct; 				// output instruction from RAM (LSB)
wire [1:0] instructA;				// actual instruction after checking
reg [1:0] Resetter;					//used to initialize the program counter

wire enabled, enabled_sta;
wire [1:0] PC;						// Counter: program counter output

initial begin

	//print out things to monitor
	$monitor ("time = %g\t PC = %b instruct = %b out = %b stat = %b", $time, PC, instruct, out, status);

	clock = 0; 				// initialize clock to be 0
	status = 0; 			// initialize status to be 0

	out= 2'b00; 			// initialize value register
	Resetter= 2'b00;		// Resettting logic

	#1 Resetter = 2'b11;	//Resetting program counter
	#1 Resetter= 2'b00;

 	//let the simulation run for 80 seconds
	#80 $finish;
end

always @(posedge monostabler)
begin
	out[0] <= adder_to_out[0];
	out[1] <= adder_to_out[1];
	status <= adder_to_stat;
end

always begin
	#4 clock = ~clock; // Generate clock
end

twoBitRam ram1(PC,instruct); 												//twoBitRam
programcounter pc(PC, openpulser, Resetter, instruct, pulse, enabled_sta); 	//Program Counter
and a1(monostabler, monostable, !status);									//monostable for adder
checking checkers(instructA, enabled, instruct);							//Check JNO

//instructional logic
increment inc(adder_to_out, adder_to_stat,pulse, monostable, out,instructA);//INC
jno jnoo(enabled, enabled_sta, openpulser, status, instructA, pulse);		//JNO
halt hlt(pulse, clock, instructA);											//HLT


endmodule

