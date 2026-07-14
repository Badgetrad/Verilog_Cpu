// Custom Module

module instruction_memory(
	input clk,
	input [7:0] address,
	output [15:0] instruction
	
	//input prog_write_en,
	//input [7:0] prog_addr,
	//input [15:0] prog_data
);

	reg [15:0] mem [0:31];
	
	
parameter LDI   = 4'h0;
parameter MOV   = 4'h1;
parameter LOAD  = 4'h2;
parameter STORE = 4'h3;

parameter ADD   = 4'h4;
parameter SUB   = 4'h5;
parameter INC   = 4'h6;
parameter DEC   = 4'h7;
parameter AND   = 4'h8;
parameter OR    = 4'h9;
parameter XOR   = 4'hA;
parameter NOT   = 4'hB;
parameter SHL   = 4'hC;
parameter SHR   = 4'hD;

parameter JMP   = 4'hE;
parameter HLT   = 4'hF;


	initial begin
		mem[0]={LDI,4'd1,8'd10};
		mem[1]={LDI,4'd2,8'd20};
		mem[2]={ADD,4'd1,4'd2,4'd0};
		mem[3]={HLT,12'd0};
	end
	/*	
	always @(posedge clk) begin
		if (prog_write_en) mem[prog_addr[4:0]] <=prog_data;
	end*/
	assign instruction=mem[address[4:0]];
endmodule
