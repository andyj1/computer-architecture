

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
