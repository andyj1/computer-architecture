
`include "two_bit_fa.v"

module increment(adder_to_out, adder_to_status, pulse, monostable, out, instructA);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] instructA; 	//input a 2 bit register from JNO
input [1:0] out;
input pulse;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

inout [1:0] adder_to_out;
output adder_to_status;
output monostable;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] instructA;
wire [1:0] out;
wire pulse;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] adder_to_out;
wire status;
reg monostable;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−
wire w1;

//−−−−−−----−-−−−−−−instructions---−−−−−−−−−−−−−−−--−−−

and (w1, pulse, !instructA[1], !instructA[0]);

initial begin
monostable = 0;
end

always @(posedge w1)
begin
	monostable = 1;
	#2
	monostable = 0;
end

fulladder adder(adder_to_status, adder_to_out, out);

endmodule
