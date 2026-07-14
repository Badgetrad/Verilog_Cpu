// Custom Module

module instruction_register(
	input clk,
	input reset,
	
	input load_en,
	input [15:0] ins_in,
	output reg [15:0] ins_out
);

	always @(posedge clk) begin
		if (reset) ins_out<=16'b0;
		else if (load_en) ins_out<= ins_in;
	end
	
endmodule
