module setStatus(status, register);

input [1:0] register;
output status;

nand na1(status, register[0], register[1]);
endmodule