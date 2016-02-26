//////////////////////////////////////////////////////////////////////////////////
// Module Name: programcounter.v
// Description: counter
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module programcounter(select, clk_pulse, reset, input_from_jno, clk, enabled);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] input_from_jno; 	//input a 2 bit register from JNO
input clk;			//input clock signal
input enabled;		//input enabling JNO register addresses
input [1:0] reset;		//for resetting
input clk_pulse;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] select;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] input_from_jno;
wire clk;
wire enabled;
wire [1:0] R;
wire clk_pulse;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] select;

//−−−−−−−−−−−−−Intermediate Wires----−−−−−−−−−−−−−−−−−−

wire [1:0] wire_select_from_logic;
wire w1, w2,w3,w4, w5, w6;
wire [1:0] wire_d_ff_input;
wire [1:0] wire_set_from_logic;
wire [1:0] wire_reset_from_logic;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
and a1(wire_set_from_logic[0], clk_pulse, enabled, input_from_jno[0]);
and a2(wire_set_from_logic[1], clk_pulse, enabled, input_from_jno[1]);
and a3(w3, clk_pulse, enabled, !input_from_jno[0]); 
and a4(w4, clk_pulse, enabled, !input_from_jno[1]);
or o1(wire_reset_from_logic[0], w3, reset[0]); //R[0] is 0, w1 goes from 0 to 1
or o2(wire_reset_from_logic[1], w4, reset[1]); //


dff_reset_posedge dff0(clk, wire_set_from_logic[0], wire_reset_from_logic[0], wire_d_ff_input[0], select[0], wire_select_from_logic[0]);
dff_reset_posedge dff1(clk, wire_set_from_logic[1], wire_reset_from_logic[1], wire_d_ff_input[1], select[1], wire_select_from_logic[1]);

and a5(w1, wire_select_from_logic[0], select[1]);
and a6(w2, wire_select_from_logic[1], select[0]);
or o3(wire_d_ff_input[1], w1, w2);
and a7(wire_d_ff_input[0], wire_select_from_logic[0],1);

endmodule

