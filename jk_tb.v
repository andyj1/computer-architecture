`include "jk.v"
module jk_tb();

reg clk;
wire qout, qnout;
reg q, qn,j,k;


initial begin 
	$monitor ("Time=%t,\t clk=%b,\t q=%b",$time,clk,q);

	clk = 0; j = 1'b1; k = 1'b1;
	q=1'b0; qn=1'b1;
	$dumpfile ("jk.vcd"); 
    //$dumpvars; 
    #10 $finish;
	end
always begin
	#1 clk = ~clk;
	
end

always@(posedge clk)
begin
	q <= ~q;
	qn <= ~q;
end

jk jk(
	qout, qnout, clk
);

endmodule