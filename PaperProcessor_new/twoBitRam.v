module twoBitRam(addr, data);

parameter Instructions = "./instruct.bin";

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0] addr;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [1:0] data;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [1:0] addr; 

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
wire [1:0] data;


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

//-------------Save Instructions In Ram----------------
reg [1:0] ram_reg [0:3];                // make register 2 bits wide  and 4 bits long
        initial begin
                $readmemb(Instructions, ram_reg);       // load program
        end
assign data = ram_reg[addr];

/*
//First Demux
//and and1_msb(a1_msb, !addr[1], !addr[0], 1'b0);
//and and2_msb(a2_msb, !addr[1], addr[0], 1'b0);
//and and3_msb(a3_msb, addr[1], !addr[0], 1'b0);
//and and4_msb(a4_msb, addr[1], addr[0], 1'b1);

//Second Demux
//and and1_lsb(a1_lsb, !addr[1], !addr[0], 1'b0);
//and and2_lsb(a2_lsb, !addr[1], addr[0], 1'b1);
//and and3_lsb(a3_lsb, addr[1], !addr[0], 1'b0);
//and and4_lsb(a4_lsb, addr[1], addr[0], 1'b0);

//Final Or Gate
//or or_msb(data[1],a1_msb,a2_msb,a3_msb,a4_msb);
//or or_lsb(data[0],a1_lsb,a2_lsb,a3_lsb,a4_lsb);
*/

endmodule
