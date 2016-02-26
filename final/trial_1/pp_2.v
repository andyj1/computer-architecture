/*
// School: The Cooper Union
// Course: ECE151A Spring 2016
// Assignment: Paper Processor (2-bit)
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
//			IS1: 	INC
//			IS2,3:  JNO 00(2)
//			IS4: 	HLT
*/

`timescale 1ns/1ns

//-------testbench for paperprocessor
// See below for the implemented modules

module paperprocessor();

reg clk;              //clock
reg status;           //status
wire [1:0] a;         //address
wire [1:0] data;      //data
wire [1:0] count;     //counter
wire [1:0] register;  //register values
reg reset;            //reset


initial fork          //initialization run in parallel 
	  clk = 0;	
		reset = 1;
		status = 0;
		$monitor ( "time = %g   clk =%g status = %b count = %b register = %b a1 = %b a0 = %b data[1] = %b, data[0] = %b", $time, clk, status, count, register, a[1], a[0], data[1], data[0]);
		#20 status = ~status;
		#22 $finish;   
join

initial begin
	$dumpfile ("paperprocessor.vcd");    //for waveform file in .vcd format
    $dumpvars;
end

always begin                            //clock toggle
	#1 clk = ~clk;
end

counter counter0(count, clk, reset);
register register0(clk, status, count, register);
setAddress setaddress(a, status, count); 
ram ram(a, data);

endmodule

//-------register module
module register(clk, status, count, register);
  parameter n = 1;
 
  output reg [n:0] register;
  input [n:0] count;
  input status, clk;
 
  // Set the initial value
  initial 
      register <= 2'b00;

  always @(posedge clk) begin             //incrementing register values
    if ((status == 0) && (count == 01)) 
          register = register + 01;
    if(register == 11) 
          register = register + 01;

    end
  always @(posedge status)                //when overflow, set register to 00
          register = 00;

endmodule

//-------setAddress module
module setAddress(address, status, counter); 

input [1:0] counter;
input status;
output [1:0] address;

wire [1:0] w; 

//determining address bits            
and a1(w[0], counter[1], ~counter[0]);
or data1(address[1], w[0], status);

and a2(w[1], ~counter[1], counter[0]);
or data2(address[0], w[1], status);

endmodule



//-------ram module


module ram(address, out);

parameter Instructions = "./instruct.bin";
//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [1:0] address;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [1:0] out;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] address;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] out;


//-------------Save Instructions In Ram----------------
reg [1:0] ram_reg [0:3];                // make register 2 bits wide  and 4 bits long
        initial begin
                $readmemb(Instructions, ram_reg);       // load program
        end
assign out = ram_reg[address];

endmodule









/*Old stuff
module ram(a, o);

input [1,0]a;
output [1,0]o;
*/
//determining data based on the address
// o1 MSB
/*
and a1(o1, a1, a0);

//o0 LSB
and a2(o0, ~a1, a0);
endmodule
*/

//-------counter module
module counter(count, clk, rst);
  parameter n = 1;
 
  output reg [n:0] count;
  input clk;
  input rst;
 
  // Set the initial value
  initial
    count = 0;
 
  // Increment count on clock
  always @(posedge clk or negedge rst)
    if (!rst)
      count = 0;
    else begin
      count = count + 1;
      if(count == 2'b11)
          count = 2'b00;
    end
endmodule
