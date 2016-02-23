//////////////////////////////////////////////////////////////////////////////////
// Module Name: fulladder.v
// Description: Full Adder where 1 is always added to the previous number
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module fulladder(stat, sum, a);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

inout [1:0] a; //input a 2 bit register

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] sum; //output 2 bit registers
output stat; //see whether registers overflown

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] a;
wire [1:0] b;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] sum;
wire stat;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−
wire w0, w1, w2, w3, w_sum0, w_sum1, w_stat;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
//set LSB of input to w_sum0
xor u0(w_sum0,a[0], 1'b1);
and (sum[0], w_sum0, 1);

//set MSB of input to w_sum1
and u1(w0, a[0], 1'b1);
xor u2(w1, a[1], 1'b0);
and u3(w2, a[1], 1'b0);
and u4(w3, w0, w1);
xor u5(w_sum1, w0, w1);
and(sum[1], w_sum1,1);

//set carry out to be w_stat
or  u6(w_stat,w2, w3);
and (stat, w_stat,1);

endmodule


