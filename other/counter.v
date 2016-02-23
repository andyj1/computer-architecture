<<<<<<< HEAD
module counter(count, clk, rst_n);
  parameter n = 1;
 
  output reg [n:0] count;
  input clk;
  input rst_n;
 
  // Set the initial value
  initial
    count = 0;
 
  // Increment count on clock
  always @(posedge clk or negedge rst_n)
    if (!rst_n)
      count = 0;
    else begin
      count = count + 1;
      if(count == 2'b11)
          count = 2'b00;
    end
endmodule
=======
module counter(count, clk, rst_n);
  parameter n = 1;
 
  output reg [n:0] count;
  input clk;
  input rst_n;
 
  // Set the initial value
  initial
    count = 0;
 
  // Increment count on clock
  always @(posedge clk or negedge rst_n)
    if (!rst_n)
      count = 0;
    else begin
      count = count + 1;
      if(count == 2'b11)
          count = 2'b00;
    end
endmodule
>>>>>>> 4c719c418537323adcdba306372967a5ab19167a
