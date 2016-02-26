//////////////////////////////////////////////////////////////////////////////////
// Module Name: fulladder.v
// Description: Full Adder where 1 is always added to the previous number
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module fulladder(status, sum, a);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

inout [1:0] a; //input a 2 bit register

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] sum; //output 2 bit registers
output status; //see whether registers overflown

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] a;
wire [1:0] b;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] sum;
wire status;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−
wire w0, w1, w2, w3;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

//set LSB of input to sum[0]
xor u0(sum[0],a[0], 1'b1);

//set MSB of input to sum[1]
and u1(w0, a[0], 1'b1);
xor u2(w1, a[1], 1'b0);
and u3(w2, a[1], 1'b0);
and u4(w3, w0, w1);
xor u5(sum[1], w0, w1);

//set carry out to be status
or u6(status,w2, w3);

endmodule


