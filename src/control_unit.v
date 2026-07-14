// Custom Module

module control_unit(
	input clk,
	input reset,
	input [3:0]opcode,
	input zero_flag,

	output reg ir_load,
	output reg pc_inc,
	output reg pc_load,
	output reg reg_write_en,
	output reg mem_write,
	output reg mem_read,
	output reg [3:0] alu_op
);

	reg [2:0] state;
	reg [2:0] next_state;
	
	parameter FETCH     = 3'd0;
	parameter DECODE    = 3'd1;
	parameter EXECUTE   = 3'd2;
	parameter MEMORY    = 3'd3;
	parameter WRITEBACK = 3'd4;
	parameter HALT = 3'd5;
	

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
	
	always @(posedge clk) begin
		if (reset) state<=FETCH;
		else state<= next_state;
	end
	
	always @(*) begin
	
		ir_load=0;
		pc_inc=0;
		pc_load=0;
		reg_write_en=0;
		mem_read=0;
		mem_write=0;
		alu_op = 4'b0;
		next_state=state;
		case (state)
		FETCH: begin
			ir_load = 1;
			next_state =DECODE;
		end
		DECODE: begin 
			case(opcode) 
			LOAD,STORE : next_state = MEMORY;
			LDI: next_state = WRITEBACK;
			HLT:next_state = HALT;
			default:next_state = EXECUTE;
			endcase
		end
		
		
		EXECUTE: begin 
			case (opcode)
				JMP: begin
            			pc_load = 1'b1;
            			next_state = FETCH;
        			end
        			default: begin
        				alu_op = opcode;
            			next_state = WRITEBACK;
        			end
			endcase
		end
		
		
		
		
		
		MEMORY:begin 
		case (opcode)

        		LOAD: begin
            		//mem_read = 1'b1;
            		next_state = WRITEBACK;
        		end

        		STORE: begin
            		mem_write = 1'b1;
            		pc_inc = 1'b1;
            		next_state = FETCH;
        		end

        		default: begin
            		next_state = FETCH;
        		end
			endcase
		end
		
		
		
		WRITEBACK: begin
			case (opcode)
			ADD,SUB,LDI,LOAD,AND,OR,XOR,NOT,SHL,SHR,INC,DEC, MOV: begin
    		        reg_write_en = 1'b1;
	            pc_inc = 1'b1;
        		    next_state = FETCH;
			end
        		default: begin
            		next_state = FETCH;
        		end
			endcase
		end

		
		
		HALT: begin
			ir_load = 0;
    			pc_inc = 0;
    			pc_load = 0;
    			reg_write_en = 0;
			next_state = HALT;
			end
	
		default: next_state=FETCH;
		endcase
	
	end

endmodule
