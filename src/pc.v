module pc(
	input clk,
	input reset,
	
	input inc,
	input load_en,
	input [7:0] load_addr,
	output reg [7:0] pc_value
);


always @(posedge clk) begin
	if (reset) pc_value<=0;
	else if (load_en) pc_value<=load_addr;
	else if (inc) pc_value<= pc_value+1;
end
endmodule