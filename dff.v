module dff (clk, set, reset, d, q); 

 	input clk, set, reset, d; 
 	output q; 
 	reg q; 

 	//for asynchronous set, reset functions
 	always @(posedge reset) 
 		q = 1'b0; 
 	always @(posedge set) 
 		q = 1'b1; 

 	//q = d after 1 ns delay of time
	always @(posedge clk) 
 		q = #1 d; 

 endmodule 
