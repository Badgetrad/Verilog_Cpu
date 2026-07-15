// Custom Module

module register(
	input clk,
	input reset,
	input [3:0] read_addr_1,
	input [3:0] read_addr_2,
	
	input [3:0] write_adrr_1,
	input [7:0] write_data,
	input write_en,
	
	output [7:0] read_data_1,
	output [7:0] read_data_2,
	output [7:0] debug_r1
);

	reg [7:0] mem [15:0];
	integer i;
	
	always @(posedge clk) begin
	if(reset) begin
		for (i=0; i<16; i=i+1) begin
			mem[i]<=8'd0;
		end
	end
	else begin
		if (write_en) mem[write_adrr_1]<=write_data;
	end
	end
	assign read_data_1=mem[read_addr_1];
	assign read_data_2=mem[read_addr_2];
	assign debug_r1 = mem[1];

endmodule


