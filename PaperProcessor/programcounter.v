//////////////////////////////////////////////////////////////////////////////////
// Module Name: programcounter.v
// Description: counter
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module programcounter(select, openpulse, R, jno, clk, enabled);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] jno; 	//input a 2 bit register from JNO
input clk;			//input clock signal
input enabled;		//input enabling JNO register addresses
input [1:0] R;		//for resetting
input openpulse;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] select;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] jno;
wire clk;
wire enabled;
wire [1:0] R;
wire openpulse;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] select;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−

wire [1:0] selectN;
wire w1, w2,w3,w4, w5, w6;
wire [1:0] D;
wire [1:0] S;
wire [1:0] R_temp;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
and a1(S[0], openpulse, enabled, jno[0]);
and a2(S[1], openpulse, enabled, jno[1]);
and a3(w3, openpulse, enabled, !jno[0]); 
and a4(w4, openpulse, enabled, !jno[1]);
or o1(R_temp[0], w3, R[0]); //R[0] is 0, w1 goes from 0 to 1
or o2(R_temp[1], w4, R[1]); //


dfff dff0(clk, S[0], R_temp[0], D[0], select[0], selectN[0]);
dfff dff1(clk, S[1], R_temp[1], D[1], select[1], selectN[1]);

and (w1, selectN[0], select[1]);
and (w2, selectN[1], select[0]);
or (D[1], w1, w2);
and (D[0], selectN[0],1);

endmodule

