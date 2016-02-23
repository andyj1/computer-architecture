`timescale 1 ns /  1 ps
module jumping_tb ();
  
  //inputs from the DUT are reg type
     reg clk, a0, b0, status, enable;
  // outputs from the DUT are wire type
     wire  pc0, pc1;
     reg[1:0] count;
     wire w0, w1, w2;

  // instantiate the Device Under Test (DUT)
  // using named instantiation
  jumping U1 ( .clk(clk), 
  				.a0(a0),
  				.b0(b0),
  				.status(status),
  				.enable(enable)
  				); 
  
  // create a 1Mhz clock
  always
    #1 clk = ~clk;   // every 1 nanoseconds invert
  //-----------------------------------------------------------
  // initial blocks are sequential and start at time 0
initial
  begin
    $display($time, " << Starting the Initialization >>");
    a0 = 0;
    b0 = 0;
    status = 0;
    count = 2'b0;
	 enable = 1'b0;
    $display($time, " << Initialization Complete >>");

  end
  
	and u0(w0, notstatus, nota0, b0);
	d_flip_flop flip(enable, w0, clk);
	and u1(w1, a0, enable);
	and u2(w2, b0, enable);
	program_counter(clk);

  task program_counter;
  input clk;
  	begin
     @ ( negedge clk )
		 count[0] <= ~count[0];
     @ ( negedge count[0] )
	    count[1] <= ~count[1];
    end
   endtask //of program_counter
  
endmodule
