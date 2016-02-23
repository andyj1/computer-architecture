<<<<<<< HEAD

module counter_tb();
 
   // Inputs
   reg clk;
   reg rst_n;
 
   // Outputs
   wire [1:0] count;
 
   // Instantiate the Unit Under Test (UUT)
    counter uut (
      .count(count), 
      .clk(clk), 
      .rst_n(rst_n)
   );
 
   initial begin
    $monitor ( "time = %g   clk =%g count = %b",
         $time, clk, count);
  
      // Initialize Inputs
      clk = 0;
      rst_n = 1;
 
      // Force Reset after delay
      #20 rst_n = 0;
      // rst_n = 1;
      $finish;
   end
 
   // Generate clock
   always
      #1 clk = !clk;
 
endmodule

=======

module counter_tb();
 
   // Inputs
   reg clk;
   reg rst_n;
 
   // Outputs
   wire [1:0] count;
 
   // Instantiate the Unit Under Test (UUT)
    counter uut (
      .count(count), 
      .clk(clk), 
      .rst_n(rst_n)
   );
 
   initial begin
    $monitor ( "time = %g   clk =%g count = %b",
         $time, clk, count);
  
      // Initialize Inputs
      clk = 0;
      rst_n = 1;
 
      // Force Reset after delay
      #20 rst_n = 0;
      // rst_n = 1;
      $finish;
   end
 
   // Generate clock
   always
      #1 clk = !clk;
 
endmodule

>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
