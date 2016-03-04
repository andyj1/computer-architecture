//////////////////////////////////////////////////////////////////////////////////
// Module Name: memory.v
// Description: loads data from instruction binary file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module memory(addr, data);

parameter Instructions = "./instruction.bin";

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [1:0] addr;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [1:0] data;

reg [1:0] ram_reg [0:3];   
wire [1:0] addr; 
wire [1:0] data;
	
//-------------load instructions---------------
//2 bit wide, 4 bit deep register memory
initial begin
        $readmemb(Instructions, ram_reg);       
end

assign data = ram_reg[addr];

endmodule
