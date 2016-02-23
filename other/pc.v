

module pc(qout,qnout,clk);
//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input clk;
//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [1:0] qout;
output [1:0] qnout;
//−−−−−−−−−−−−−Registers−−−−−−−−−−−−−−−−−−
reg [1:0] q;
reg [1:0] qn;
reg j,k;
wire [7:0] w;

  		nand na1(w[0], clk, qn[0], j);
  		nand na2(w[1], clk, q[0], k);
  		nand na3(w[4], w[0], qn[0]);
  		nand na4(w[5], w[1], q[0]);

  		and a1(qout[0], 1'b1, w[4]);
  		and a2(qnout[0],1'b1, w[5]);

  		nand na5(w[2], w[5], qn[1], j);
  		nand na6(w[3], w[5], qn[1], k);
  		nand na7(w[6], w[2], qn[1]);
  		nand na8(w[7], w[3], q[1]);

		and a1(qout[1],1'b1, w[6]);
  		and a2(qnout[1],1'b1, w[7]);

endmodule
