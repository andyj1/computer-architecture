//-------setAddress module
module setAddress(address, status, counter); 

input [1:0] counter;
input status;
output [1:0] address;

wire [1:0] w; 

//determining address bits            
and a1(w[0], counter[1], ~counter[0]);
or data1(address[1], w[0], status);

and a2(w[1], ~counter[1], counter[0]);
or data2(address[0], w[1], status);

endmodule