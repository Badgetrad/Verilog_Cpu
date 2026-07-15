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
	
	

parameter NOP = 4'h0;
parameter LDI   = 4'h1;
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
/*

mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {LDI, 4'd2, 8'd20};
mem[2] = {ADD, 4'd1, 4'd2, 4'd0}; // Expected: R1 = 30
mem[3] = {HLT, 12'd0};


mem[0] = {LDI, 4'd1, 8'd50};
mem[1] = {LDI, 4'd2, 8'd20};
mem[2] = {SUB, 4'd1, 4'd2, 4'd0}; // Expected: R1 = 30
mem[3] = {HLT, 12'd0};



mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {INC, 4'd1, 8'd0};
mem[2] = {HLT, 12'd0};

mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {DEC, 4'd1, 8'd0};
mem[2] = {HLT, 12'd0};


mem[0] = {LDI, 4'd1, 8'd12}; // 1100
mem[1] = {LDI, 4'd2, 8'd10}; // 1010
mem[2] = {AND, 4'd1, 4'd2, 4'd0}; // Expected: R1 = 8
mem[3] = {HLT, 12'd0};



mem[0] = {LDI, 4'd1, 8'd12};
mem[1] = {LDI, 4'd2, 8'd10};
mem[2] = {OR, 4'd1, 4'd2, 4'd0}; // Expected: R1 = 14
mem[3] = {HLT, 12'd0};


mem[0] = {LDI, 4'd1, 8'd12};
mem[1] = {LDI, 4'd2, 8'd10};
mem[2] = {XOR, 4'd1, 4'd2, 4'd0}; // Expected: R1 = 6
mem[3] = {HLT, 12'd0};


mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {NOT, 4'd1, 8'd0}; // Expected: R1 = 245
mem[2] = {HLT, 12'd0};



mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {SHL, 4'd1, 8'd0}; // Expected: R1 = 20
mem[2] = {HLT, 12'd0};




mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {SHR, 4'd1, 8'd0}; // Expected: R1 = 5
mem[2] = {HLT, 12'd0};

mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {JMP, 12'd3};
mem[2] = {LDI, 4'd1, 8'd99};
mem[3] = {INC, 4'd1, 8'd0}; // Expected: R1 = 11
mem[4] = {HLT, 12'd0};

*/


mem[0] = {LDI, 4'd1, 8'd10};
mem[1] = {LDI, 4'd2, 8'd20};
mem[2] = {ADD, 4'd1, 4'd2, 4'd0}; // Expected: R1 = 30
mem[3] = {HLT, 12'd0};



	end
	/*	
	always @(posedge clk) begin
		if (prog_write_en) mem[prog_addr[4:0]] <=prog_data;
	end*/
	assign instruction=mem[address[4:0]];
endmodule
