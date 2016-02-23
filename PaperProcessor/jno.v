//////////////////////////////////////////////////////////////////////////////////
// Module Name: jno.v
// Description: from the current instructions, outputs ENABLE for checking and counter 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module jno(enabling, enabling_sta, openpulse, sta, instruct, pulses);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] instruct; 	//input a 2 bit register from JNO
input pulses;
input sta;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output enabling;
output enabling_sta;
output openpulse;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] instruct;
wire pulses;
wire sta;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire enabling;
wire enabling_sta;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−
reg s;
reg r;
wire notenabling, notenabling_sta;
wire w1, w2;
reg mem;
reg pulser;
wire openpulse;
reg openpulser;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
initial begin
s = 0;
r = 0;
pulser = 0;
openpulser = 0;
end

and a1(w1, !instruct[1], instruct[0]);
and a2(w2, !sta, !instruct[1], instruct[0]);
and a3 (openpulse, !sta, openpulser);

always @(posedge w1)
begin
	#1
	pulser = 1;
	#8
	openpulser = 1;
	#4
	openpulser = 0;
	#1
	pulser = 0;
	#1
	pulser = 1;
	#1
	pulser = 0;
end
dff dff3(pulser, s, r, w1, enabling, notenabling); //enabling the checking
dff dff4(pulser, s, r, w2, enabling_sta, notenabling_sta); //enabling for counter

endmodule