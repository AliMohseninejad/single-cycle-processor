`timescale 1ns/1ns

module MIPS (
	input clk,reset
) ;

	wire MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegW,SgnZero,zero ;
	wire [2:0] ALUOP ;
	wire [5:0] op,funct ;

	DataPath dp (clk,reset,MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegW,SgnZero,ALUOP,op,funct,zero) ;
	controller c (op,funct,zero,MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegW,SgnZero,ALUOP) ;

endmodule 