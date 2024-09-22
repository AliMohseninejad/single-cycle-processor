`timescale 1ns/1ns

module DataPath (
	input clk,reset,MemToReg,MemWrite,PCSrc, ALUSrc, RegDst, RegW, SgnZero,
	input [2:0] ALUOP,
	output [5:0] op,funct,
	output zero
) ;

	// PC build
	wire [31:0] PC0 ;
	wire [31:0] PC ;
	PC_unit PC_build (PC0,clk,reset,PC) ;
	
	wire [31:0] PCPlus4 ;
	adder adder1 (PC,32'd4,PCPlus4) ;

	
	// Instruction Memory
	wire [31:0] instr ;
	InstructionMemory mem (PC,instr) ;
	
	assign op = instr [31:26] ;
	assign funct = instr [5:0] ;
	
	// extention and ...
	wire [31:0] SignImm ;
	extention extend (instr[15:0],SgnZero,SignImm) ;
	
	wire [31:0] shifted_Imm ;
	shift shift1 (SignImm,shifted_Imm) ;
	
	wire [31:0] PCBranch ;
	adder adder2 (shifted_Imm,PCPlus4,PCBranch) ;

	MUX #(32) mux1 (PCPlus4,PCBranch,PCSrc,PC0) ; 
	
	// register file
	wire [4:0] WriteReg ;
	MUX #(5) mux2 (instr[20:16],instr[15:11],RegDst,WriteReg) ;

	wire [31:0] Result,SrcA,RD2 ;
	RegisterFile reg_file (clk,RegW,instr[25:21],instr[20:16],WriteReg,Result,SrcA,RD2) ;

	// ALU
	wire [31:0] SrcB ;
	MUX #(32) mux3 (RD2,SignImm,ALUSrc,SrcB) ;

	wire [31:0] ALUResult ;
	ALU alu_unit (SrcA,SrcB,ALUOP,ALUResult,zero) ;

	// Data Memory
	wire [31:0] ReadData ;
	wire MemReady ;
	DataMemory #(0) dm (clk,MemWrite,ALUResult,RD2,ReadData,MemReady) ;  
	
	MUX #(32) mux4 (ALUResult,ReadData,MemToReg,Result) ; 




endmodule 