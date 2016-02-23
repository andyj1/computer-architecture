<<<<<<< HEAD
//////////////////////////////////////////////////////////////////////////////////
// Module Name: checking.v
// Description: checks if either of two inputs is HIGH at a certain time
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module checking(checked, enabling, check);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] check; 	//input a 2 bit register from JNO
input enabling;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] checked;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] check;
wire enabling;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] checked;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−


//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

or o1(checked[1], enabling, check[1]);
or o2(checked[0], enabling, check[0]);


=======
//////////////////////////////////////////////////////////////////////////////////
// Module Name: checking.v
// Description: checks if either of two inputs is HIGH at a certain time
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module checking(checked, enabling, check);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] check; 	//input a 2 bit register from JNO
input enabling;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] checked;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] check;
wire enabling;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] checked;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−


//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

or o1(checked[1], enabling, check[1]);
or o2(checked[0], enabling, check[0]);


>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
endmodule