// Custom Module

module memory(
	input clk,
	input reset,
	input [7:0] address,
	input [7:0] write_data,
	input write_en,
	
	output [7:0] read_data
);

	reg [7:0] mem [0:31];
	
	always @(posedge clk) begin
		if (write_en) mem[address[4:0]]=write_data;
	end
	assign read_data=mem[address[4:0]];
	
endmodule
