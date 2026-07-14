// Custom Module

module Instruction_decoder(
	input [15:0] instruction,
	
	output [3:0] opcode,
	output [3:0] rd,
	output [3:0] rs,
	output [7:0] immediate,
	output [7:0] address
);

	assign opcode = instruction[15:12];
	assign rd= instruction[11:8];
	assign rs= instruction[7:4];
	assign immediate= instruction[7:0];
	assign address = instruction [7:0];

endmodule
