module checking(instructA, enabled, instruct);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] instruct; 	//input a 2 bit register from JNO
input enabled;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] instructA;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] instruct;
wire enabled;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] instructA;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−


//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

or o1(instructA[1], enabled, instruct[1]);
or o2(instructA[0], enabled, instruct[0]);


endmodule