// Custom Module

module alu(
	input [7:0] reg_a,
	input [7:0] reg_b,
	input [3:0] opcode,
	output reg [7:0] out,
	output wire zero
);
	
	reg [7:0] temp;
	
	always @(*) begin
		case(opcode)
		4'h4: out= reg_a + reg_b;
		4'h5: out= reg_a - reg_b;
		4'h6: out= reg_a+1 ;
		4'h7: out= reg_a-1 ;
		4'h8: out= reg_a & reg_b;
		4'h9: out= reg_a | reg_b;
		4'hA: out= reg_a ^ reg_b;
		4'hB: out= ~reg_a;
		4'hC: out= reg_a << 1;
		4'hD: out= reg_a >> 1;
		4'h1: out = reg_b;
		default: out= reg_a;
		endcase
	end
	assign zero= (out==8'b0);


endmodule
