<<<<<<< HEAD


module jk(j,k,clk, q);  //output: q, qn | input: clk
//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input j,k,clk;
//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output q;
//−−−−−−−−−−−−−Registers−−−−−−−−−−−−−−−−−−
wire q;
wire [1:0] w;

  		nand na1(w[0], clk, ~q, j);
  		nand na2(w[1], clk, q, k);
  		nand na3(q, w[0], ~q);

endmodule
=======


module jk(j,k,clk, q);  //output: q, qn | input: clk
//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input j,k,clk;
//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output q;
//−−−−−−−−−−−−−Registers−−−−−−−−−−−−−−−−−−
wire q;
wire [1:0] w;

  		nand na1(w[0], clk, ~q, j);
  		nand na2(w[1], clk, q, k);
  		nand na3(q, w[0], ~q);

endmodule
>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
