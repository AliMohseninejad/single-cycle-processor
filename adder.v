`timescale 1ns/1ns

module adder (
	input [31:0] a,b,
	output [31:0] sum
) ;

	assign sum = a + b ;

endmodule 