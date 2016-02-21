module register(clk, status, count, register);
  parameter n = 1;
 
  output reg [n:0] register;
  input [1:0] count;
  input status, clk;
 
  // Set the initial value
  initial 
      register <= 2'b00;

  always @(posedge clk) begin
    if ((status == 0) && (count == 01)) 
          register = register + 01;
    if(register == 11) 
      register = register + 01;

    end
  always @(posedge status)
          register = 00;
endmodule

