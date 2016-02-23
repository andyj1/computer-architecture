`include "jk.v"
module jk_tb();

reg j,k,clk;
wire q;


initial begin 
	$monitor ("Time=%t,\t clk=%b,\t qout=%b",$time,clk,q);

	clk = 0; j = 1'b1; k = 1'b1;
	q = 1'b0;
	
	$dumpfile ("jk.vcd"); 
    $dumpvars; 
    
    #-0 $finish;
	end

always begin
	#1 clk = ~clk;
end

always @(posedge clk)
begin
	q <= ~q;
end

jk jk0(
	j, k, clk, q
);

endmodule