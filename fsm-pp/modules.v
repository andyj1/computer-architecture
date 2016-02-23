module register(clk, reset, register_out_1, register_out_0, status, data_1, data_0, register_1, register_0);
	input clk, reset, data_1, data_0, register_1, register_0;
	output register_out_1, register_out_0, status;
	wire [2:0] w;

	and a1(w[0], register_1, ~register_0);
	and a2(w[1], register_0, ~register_1);
	or or1(w[2], w[0], w[1]);
	and a3(register_out_1, w[2], ~data_1, ~data_0);

	and a4(register_out_0, ~register_0, ~data_1,~data_0);

	and a5(status, register_1, register_0, ~data_1, ~data_0);

endmodule 	



module address (clk, reset, address_out_1, address_out_0, status, data_1, data_0, address_1, address_0);
	input clk, reset, data_1, data_0, status, address_1, address_0;
	output address_out_1, address_out_0;

	wire [4:0] w;

	and a1(w[0], ~data_1, data_0, ~status);
	or or1(w[1], w[0], status);
	and a2(address_out_1, ~w[1], address_0, ~address_1);
	
	and a3(w[2], address_0, status);
	and a4(w[3], ~address_0, ~data_1, ~data_0, ~status);
	or or2(w[4], w[3], w[2]);
	and a5(address_out_0, w[4], ~address_1);
endmodule


module data (clk, reset, data_1, data_0, status, address_1, address_0, data_out_1, data_out_0);
	input clk, reset, data_1, data_0, status, address_1, address_0;
	output data_out_1, data_out_0;

	and a1(data_out_1, ~data_1, data_0, address_1, address_0, status);
	and a2(data_out_0, ~data_1, ~data_0, ~address_1, address_0, ~status);

endmodule


module dff (clk, d, reset, q);

input clk, d, reset;
output q;
reg q;

always @ (posedge clk)
	if (reset) 
		q <= 1'b0;
	else 
		q <= d;
	
endmodule




