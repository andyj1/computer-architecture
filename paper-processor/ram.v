<<<<<<< HEAD
//-------ram module
module ram(address, out);

parameter Instructions = "./instruct.bin";
input [1:0] address;

output [1:0] out;

// By rule all the input ports should be wires
wire [1:0] address;

// Output port can be a storage element (reg) or a wire
wire [1:0] out;

//-------------Save Instructions In Ram----------------
reg [1:0] ram_reg [0:3];                // make register 2 bits wide  and 4 bits long
        initial begin
                $readmemb(Instructions, ram_reg);       // load program
        end
assign out = ram_reg[address];

=======
//-------ram module
module ram(address, out);

parameter Instructions = "./instruct.bin";
input [1:0] address;

output [1:0] out;

// By rule all the input ports should be wires
wire [1:0] address;

// Output port can be a storage element (reg) or a wire
wire [1:0] out;

//-------------Save Instructions In Ram----------------
reg [1:0] ram_reg [0:3];                // make register 2 bits wide  and 4 bits long
        initial begin
                $readmemb(Instructions, ram_reg);       // load program
        end
assign out = ram_reg[address];

>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
endmodule