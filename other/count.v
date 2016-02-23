<<<<<<< HEAD
module setcounter(counter, status);  //using status as enable for pc

input status;
output [1:0] counter;
wire [1:0] count;

xnor xnor0(counter[0], s, count[0]);
or or0(counter[1], s, count[1]);
=======
module setcounter(counter, status);  //using status as enable for pc

input status;
output [1:0] counter;
wire [1:0] count;

xnor xnor0(counter[0], s, count[0]);
or or0(counter[1], s, count[1]);
>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
endmodule