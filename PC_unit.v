`timescale 1ns/1ns

module PC_unit (
	input [31:0] PC0,
	input clk,reset,
	output reg [31:0] PC 
) ;

	always @(posedge clk,posedge reset)
		if (reset)
			PC <= 32'h00000000 ;
		else
			PC <= PC0 ;

endmodule 