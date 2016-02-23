<<<<<<< HEAD
module setStatus(status, register);

input [1:0] register;
output status;

nand na1(status, register[0], register[1]);
=======
module setStatus(status, register);

input [1:0] register;
output status;

nand na1(status, register[0], register[1]);
>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
endmodule