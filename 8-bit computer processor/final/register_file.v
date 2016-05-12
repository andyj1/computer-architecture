//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module register_file (rt_data, rs_data, s1_data, s2_data, sp_data, ra_data, regWrite, beqctrl, jrctrl, memctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr, clk);

input wire regWrite;
input wire beqctrl;
input wire jrctrl;
input wire ALUsrc;		//I type control for immediate
input wire [1:0] rt_addr;
input wire [1:0] rs_addr;
input wire [7:0] dataToWrite;
input wire [1:0] slt_reg;	
input wire [1:0] rs_write_addr;
input wire memctrl;

output reg [7:0] rt_data;
output reg [7:0] rs_data;

output reg [7:0] s1_data;
output reg [7:0] s2_data;
output reg [7:0] sp_data;
output reg [7:0] ra_data;

reg [7:0] data_reg [3:0]; 	 
reg [1:0] address_reg [3:0];	//3:$ra, 2:$sp, 1: $s1, 0: $s0
reg [7:0] t0;
reg [7:0] t1;

input wire clk;

//------------------Instructions-----------------------
initial 
	begin
		
		address_reg[3] = 2'b11;		//addr of ra
		address_reg[2] = 2'b10;		//addr of sp
		address_reg[1] = 2'b01;		//addr of s1
		address_reg[0] = 2'b00;		//addr of s0
		data_reg[3] = 8'b00000000;	//data of ra 
		data_reg[2] = 8'b11111111;	//data of sp
		data_reg[1] = 8'b00000000;	//data of s1
		data_reg[0] = 8'b00000000;	//data of s0
		t0 = 8'b00000000;
		t1 = 8'b00000000;
		
		rt_data = 8'b00000000;
		rs_data = 8'b00000000;
		s1_data = 0;
		s2_data = 0;
		sp_data = 0;
		ra_data = 0;
	end

//when there is an input address, data reg at that input address = its dataReadReg
always @(posedge clk)
	begin
	if (beqctrl == 0) 
		begin
			rt_data = data_reg[rt_addr];
			//rs_data = data_reg[rs_addr];
			if (jrctrl == 1) begin					//jrctrl = 1 for JR type
				rs_data = data_reg[rs_write_addr];	//when jrctrl, rs_write_addr = 11 (addr of $ra)
			end else begin
				rs_data = data_reg[rs_addr];
			end
		end 
		if (memctrl == 1) begin

			rt_data = data_reg[rs_addr];
			//$display("rt_data in regfile: %b", rt_data);
			rs_data = data_reg[2];		
		
		end
		if (regWrite == 1) 
			#1
			begin
				if (slt_reg == 2'b10) begin
					t0 = dataToWrite;
					//$display("t0: %b t1: %b", t0, t1);
				end if (slt_reg == 2'b11) begin
					t1 = dataToWrite;
				end if(slt_reg == 2'b00 || slt_reg == 2'b01) begin
					data_reg[rs_write_addr] = dataToWrite;
					//$display("Hello!");
				end

			end
		if (beqctrl == 1) begin
			//$display("Hello!");
			rt_data = t0;
			rs_data = t1;
		end
	end
always @*
begin
	s1_data = data_reg[0];
	s2_data = data_reg[1];
	sp_data = data_reg[2];
	ra_data = data_reg[3];

end
endmodule
