module ram(a1, a0, o1, o0);

input a1;
input a0;
output o1;
output o0;
wire [2:0] w;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
/*
Instructions:
INC: 00
JNO: 01
HLT: 10
in1: INC
in2: JNO
in3: 00
in4: HLT
*/

// o1
and a1(o1, a1, a0);

//o0
and a2(o0, ~a1, a0);

endmodule