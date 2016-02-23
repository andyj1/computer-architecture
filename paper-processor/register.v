//-------register module
module register(clk, status, count, register);
  parameter n = 1;
 
  output reg [n:0] register;
  input [n:0] count;
  input status, clk;
 
  // Set the initial value
  initial 
      register <= 2'b00;

  always @(posedge clk) begin     //incrementing register values
    if ((status == 0) && (count == 01)) 
          register = register + 01;
    if(register == 11) 
          register = register + 01;

    end
  always @(posedge status)                //when overflow, set register to 00
          register = 00;

endmodule