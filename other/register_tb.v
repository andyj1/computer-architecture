
module register_tb();
 
   // Inputs
   reg [1:0] count;
   reg status, clk;

   // Outputs
   wire [1:0] register;
 
   // Instantiate the Unit Under Test (UUT)
    register uut (
      .status(status),
      .count(count),  
      .register(register)
   );
 
   initial begin
    $monitor ( "time = %g   clk =%g status = %b count = %b register = %b",
         $time, clk, status, count, register);
  
      // Initialize Inputs
      clk = 0;
      status = 0;
      count = 2'b00;
      #1 count = 2'b01;
      #1 count = 2'b11;
      #1 count = 2'b00;
      // Force Reset after delay
      #10 status = 1;
      $finish;
   end
 
   // Generate clock
   always
      #1 clk = !clk;
 
endmodule

