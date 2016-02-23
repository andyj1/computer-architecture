`include "modules.v"
module mainbench();
	wire sr, ro1, ro0, roo1,roo0,ao1,ao0,aoo1,aoo0,do1,do0,doo1,doo0;
	reg r1,r0,a1,a0,d1,d0;
	reg rst,clock;
	


	initial begin
		#1 clock = ~clock;
		rst = 1'0;
		$monitor ("clk =%g status = %b address = %b%b register = %b%b data = %b%b", clock, sr,  a1,a0, r1,r0, d1,d0);
		r1 = 1'b0; r0 = 1'b0; a1 = 1'b0; a0 = 1'b0;
		d1 = 1'b0; d0 = 1'b0;

		$dumpfile ("main.vcd");  
   		$dumpvars;
	end

	register register0(clock, rst, ro1, ro0, sr, do1,do0,r1,r0);

	dff dff0(clock, ro0, rst, roo0);
	dff dff1(clock, ro1,rst,roo1);

	address address0(clock, rst,ao1,ao0,sr,d1,d0,a1,a0);

	dff dff2(clock, ao0,rst,aoo0);
	dff dff3(clock, ao1,rst,aoo1);

	data data0(clock, rst,d1,d0,sr,ao1,ao0,do1,do0);

	dff dff4(clock, do0,rst,doo0);
	dff dff5(clock, do1,rst,doo1);
endmodule
