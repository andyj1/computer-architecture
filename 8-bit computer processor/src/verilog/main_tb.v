//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "add1.v"
`include "pc.v"
`include "memory.v"
`include "instruction_reg.v"
`include "signext_2to8.v"
`include "signext_5to8.v"
`include "mux2_1_ctrl1.v"
`include "mux2_1_ctrl1_in2.v"
`include "ctrl.v"
`include "register_file.v"
`include "ALUctrlunit.v"
`include "ALUctrl.v"
`include "ALU.v"
`include "mux2_1_ctrl1_out1.v"
`include "mux3_1.v"
`include "addimm.v"

module main_tb ();
//WIRES
wire [7:0] pcAddrIn;		//new pc address
wire [7:0] pcAddrOut;		//current pc address
wire [7:0] instruction;		//current instruction
wire [7:0] rt_data;		//Data from rt that goes into ALU
wire [7:0] rs_data;		//Data from rs that goes into ALU
wire [2:0] ALUctrlbits;		//ALU control 
wire jumpFlag_ALUctrl;		//branching decision
wire [7:0] ALUresult;		//results from calculation of main ALU
wire beqSatisfied;
wire sltReg;
wire [7:0] pcAddrOutPlusImm;
wire [7:0] pcFinalOut;
wire [7:0] jrAddr;
wire [7:0] jalAddr;
//wire [7:0] pcAddrIn;
wire [1:0] nextctrl;
wire [7:0] pcAddrOutPlusOne;

//DECODER
wire [7:0] readData;		//data read from instruction memory, currently unused
wire [4:0] jImm5;		//inst[4:0], obtain PC relative address
wire [7:0] jImm8;		//extended jImm5
wire [1:0] jumpCheck2;	//inst[7:6], to see whether instruction is jump
wire [7:0] jumpCheck8;	//extended jOpCodeCheck
wire [2:0] inst2CtrlUnit;		//Opcode from instruction register
wire [1:0] rtAddr;
wire [1:0] rsAddr;
wire [1:0] iImm2;
wire funct;
wire jumpCtrlToMux;		//Ctrl to MUX for control unit (ctrlJumpMUX)
wire muxJumpFlag;		//jump control that ultimately goes into ctrl unit 

//REGISTER FILE
wire [7:0] rtData;
wire [7:0] rsData;
wire [1:0] rsWriteAddr;	
wire [7:0] dataToWrite;
wire [7:0] muxALUsrc;
wire [7:0] iImm8;
reg [1:0] returnAddr;

wire [7:0] s1_data;
wire [7:0] s2_data;
wire [7:0] sp_data;
wire [7:0] ra_data;

//CONTROLS FROM CONTROL UNIT
wire jctrl; 				//control jal MUX
wire jrctrl;				//control jr MUX
wire memWrite;				//control to write to data memory
wire memRead;				//control to read from data memory
wire [1:0] memToReg;			//control of writeback
wire [2:0] ALUOp;			//control to ALU control
wire ALUsrc;				//control to MUXing between rt and immediate
wire regWrite;				//control to register write
wire beqctrl;				//control for beq
wire ractrl;				//control for choosing between ra and rs
wire jalctrl;				//control choosing between PC and PC+immediate for jal
wire [1:0]sltCtrl;			//control for slt_0 and slt_1
wire memctrl;

//REGISTERS
reg clk;
reg zero;		//register that stores the memory 0 for comparisons

//TEMPORARY
reg reset;		//reset pc counter


//------------------Instructions-----------------------

always begin
	#1 clk = ~clk;
	end
initial 
	begin
		$dumpfile ("bag.vcd");    //waveform file output in .vcd format
		$dumpvars;
		//initialize unused wires
		clk = 0;
		reset = 1;
		zero = 0;
		//pcAddrIn = 8'b00000000;
		returnAddr = 2'b11;
		#2 reset = 0;
		$monitor("pc: %d instruction: %b s1: %b s2: %b sp: %b ra: %b ", pcAddrOut,instruction,s1_data, s2_data, sp_data, ra_data, );
		#256 $finish;
	end


//Main PC counter						
pc program_counter(pcAddrOut, clk, pcFinalOut, reset, instruction); 
//INPUT: clk, pcFinalOut, reset, instruction (current pc)
//OUTPUT: pcAddrOut 

//---------------------------------------------------------------------------
memory main_memory(instruction, readData, pcAddrOut, memWrite, memRead, ALUresult, rtData); 
//INPUT: pcAddrOut, memWrite, memRead, ALUresult, rtData
//OUTPUT: instruction, readData

//---------------------------------------------------------------------------
instruction_reg instruction_register(jImm5, jumpCheck2, inst2CtrlUnit, rtAddr, rsAddr, iImm2, funct, instruction);	//instruction register for decoding
//INPUT: instruction
//OUTPUT: jImm5, jumpCheck2, inst2CtrlUnit, rtAddr, rsAddr, iImm2, funct

//---------------------------------------------------------------------------
signext_2to8 extension_2to8_1(jumpCheck8, jumpCheck2);	//sign extension for jump opcode check
//INPUT: jumpCheck2
//OUTPUT: jumpCheck8

//---------------------------------------------------------------------------
signext_5to8 extension_5to8(jImm8, jImm5);			//sign extension for jump immediate
//INPUT: jImm5
//OUTPUT: jImm8

//---------------------------------------------------------------------------
signext_2to8 extension_2to8_2(iImm8, iImm2);			//sign extension for I instruction
//INPUT: iImm2
//OUTPUT: iImm8

//---------------------------------------------------------------------------
ALU compareJump(jumpCtrlToMux, jumpCheck8);	//Check for jump code
//INPUT: jumpCheck8
//OUTPUT: jumpCtrlToMux

//---------------------------------------------------------------------------
mux2_1_ctrl1 ctrlJumpMux(muxJumpFlag, zero, funct, jumpCtrlToMux);		//choose between Jumps
//INPUT: zero, funct
//OUTPUT: muxJumpFlag
//CONTROL: jumpCtrlToMux

//---------------------------------------------------------------------------
mux2_1_ctrl1_out1 ctrlJR(rsWriteAddr, rsAddr, returnAddr, ractrl);		//choose between ra and rsAddr
//INPUT: rtAddr, returnAddr
//OUTPUT: rsWriteAddr
//CONTROL: ractrl

//---------------------------------------------------------------------------
ctrl control_unit(jctrl, jrctrl, memWrite, memRead, memToReg, ALUOp, ALUsrc, nextctrl, regWrite, beqctrl, ractrl, jalctrl, sltCtrl, memctrl, inst2CtrlUnit, muxJumpFlag);
//INPUT: inst2CtrlUnit, muxJumpFlag(== funct if R or I type)
//OUTPUT: jctrl, jrctrl, memWrite, memRead, memToReg, ALUOp, ALUsrc, nextctrl, regWrite, beqctrl, ractrl, jalctrl, sltCtrl

//---------------------------------------------------------------------------
//Register File		
register_file register_file(rtData, rsData, s1_data, s2_data, sp_data, ra_data, regWrite, beqctrl, jrctrl, memctrl, ALUsrc,  rtAddr, rsAddr, dataToWrite, sltCtrl, rsWriteAddr, clk);
//INPUT: regWrite, beqctrl, jrctrl, ALUsrc, rtAddr, rsWriteAddr, dataToWrite, sltCtrl, rsAddr
//OUTPUT: rtData, rsData, s1_data, s2_data, sp_data, ra_data

//---------------------------------------------------------------------------
mux2_1_ctrl1_in2 ctrl_immmediate(muxALUsrc, rtData, iImm8, ALUsrc);			//choose between rt and immediate
//INPUT: rtData, iImm8
//OUTPUT: muxALUsrc
//CONTROL: ALUsrc

//---------------------------------------------------------------------------
ALUctrlunit alu_ctrl_unit(ALUctrlbits, ALUOp, funct);		
//INPUT: ALUOp, funct
//OUTPUT: ALUctrlbits

//---------------------------------------------------------------------------
ALUctrl alu_with_ctrl(jumpFlag_ALUctrl, ALUresult, sltReg, ALUctrlbits, muxALUsrc, rsData, clk);		
//INPUT: ALUctrlbits, muxALUsrc, rsData
//OUTPUT: jumpFlag_ALUctrl, ALUresult, sltReg		here: ALUresult is computed value if R type, effective address in memory if I type

//---------------------------------------------------------------------------
add1 addition_1(pcAddrOut, pcAddrOutPlusOne);			
//INPUT: pcAddrOut
//OUTPUT pcAddrOutPlusOne					for R or I type, PC(final) = PC(current) + 1

//---------------------------------------------------------------------------
addimm addition_imm(pcAddrOutPlusImm, pcAddrOut, jImm8);
//INPUT: pcAddrIn
//OUTPUT: pcAddrOutPlusImm					for J type, PC(final) = PC(current) + immediate
//IMMEDIATE: jImm8

//---------------------------------------------------------------------------pcPlusTwo == originally pcAddrIn
mux3_1 ctrl_write_back(dataToWrite, ALUresult, readData, pcAddrOutPlusOne, memToReg);		//choose between memory, ALU and PC to writeback to regFile
//INPUT: ALUresult, readData, pcAddrOutPlusOne (for jal next pc)
//OUTPUT: dataToWrite
//CONTROL: memToReg
//---------------------------------------------------------------------------
and and_1(beqSatisfied, jumpFlag_ALUctrl, beqctrl);
//INPUT: jumpFlag_ALUctrl, beqctrl
//OUTPUT: beqSatisfied
//---------------------------------------------------------------------------
or or_1(jumpDecision, jctrl, beqSatisfied);
//INPUT: jctrl, beqSatisfied
//OUTPUT: jumpDecision
//---------------------------------------------------------------------------
mux2_1_ctrl1_in2 ctrljalMUX(jalAddr, pcAddrOutPlusOne, pcAddrOutPlusImm, jumpDecision);		//choose between pc+imm and pc+1
//---------------------------------------------------------------------------
//INPUT: pcAddrOutPlusOne, pcAddrOutPlusImm
//OUTPUT: jalAddr
//CONTROL: jumpDecision
mux2_1_ctrl1_in2 ctrljrMUX(pcFinalOut, jalAddr, rsData, jrctrl);			//choose between jr $ra and whatever comes from from ctrljalMUX
//---------------------------------------------------------------------------
//INPUT: jalAddr, rsData
//OUTPUT: pcFinalOu
//CONTROL: jrctrl

endmodule




