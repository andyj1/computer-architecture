

module jk(q,qn,clk);  //output: q, qn | input: clk
//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input clk;
//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output q,qn;
//−−−−−−−−−−−−−Registers−−−−−−−−−−−−−−−−−−
wire q,qn,j,k;
wire [1:0] w;

  		nand na1(w[0], clk, qn, j);
  		nand na2(w[1], clk, q, k);
  		nand na3(q, w[0], qn);
  		nand na4(qn, w[1], q);

endmodule
