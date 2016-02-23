<<<<<<< HEAD
`include "setAddress.v"
`include "ram.v"
`include "counter.v"
`include "register.v"

module process_tb();

reg clk;
wire s;       //status
wire [1:0] c; //pc
wire [1:0] r; //register;
wire [1:0] a; //address
wire [1:0] data; //data

reg status;
wire status_0;
wire [1:0] count;
wire [1:0] register;
reg reset;


	initial fork
		
		clk = 0;	
		reset = 1;
		status = 0;
		$monitor ( "time = %g   clk =%g status = %b count = %b register = %b a1 = %b a0 = %b data[1] = %b, data[0] = %b",
			   $time, clk, status, count, register, a[1], a[0], data[1], data[0]);

		#20 status=~status;
		#22 $finish;   
	join

initial begin
	$dumpfile ("processor.vcd"); 
    $dumpvars;
end

always begin
	#1 clk = ~clk;
end

counter counter0(count, clk, reset);
register register0(clk, status, count, register);
setAddress setaddress(a, status, count); 
ram ram(a[1], a[0], data[1], data[0]);

endmodule
=======
`include "setAddress.v"
`include "ram.v"
`include "counter.v"
`include "register.v"

module process_tb();

reg clk;
wire s;       //status
wire [1:0] c; //pc
wire [1:0] r; //register;
wire [1:0] a; //address
wire [1:0] data; //data

reg status;
wire status_0;
wire [1:0] count;
wire [1:0] register;
reg reset;


	initial fork
		
		clk = 0;	
		reset = 1;
		status = 0;
		$monitor ( "time = %g   clk =%g status = %b count = %b register = %b a1 = %b a0 = %b data[1] = %b, data[0] = %b",
			   $time, clk, status, count, register, a[1], a[0], data[1], data[0]);

		#20 status=~status;
		#22 $finish;   
	join

initial begin
	$dumpfile ("processor.vcd"); 
    $dumpvars;
end

always begin
	#1 clk = ~clk;
end

counter counter0(count, clk, reset);
register register0(clk, status, count, register);
setAddress setaddress(a, status, count); 
ram ram(a[1], a[0], data[1], data[0]);

endmodule
>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
