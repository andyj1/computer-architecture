//-------counter module
module counter(count, clk, rst);
  parameter n = 1;
 
  output reg [n:0] count;
  input clk;
  input rst;
 
  // Set the initial value
  initial
    count = 0;
 
  // Increment count on clock
  always @(posedge clk or negedge rst)
    if (!rst)
      count = 0;
    else begin
      count = count + 1;
      if(count == 2'b11)
          count = 2'b00;
    end
endmodule
