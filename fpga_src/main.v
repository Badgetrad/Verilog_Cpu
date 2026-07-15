(* top *) module top ( 
	(* iopad_external_pin, clkbuf_inhibit *) input clk, 	// System Clock (50MHz) 
	(* iopad_external_pin *) output clk_en, 
	(* iopad_external_pin *) input rst_n, 			   	// System Reset (Active Low) 
	
	// Physical SPI Pins (Connect these to FPGA I/O) 
	(* iopad_external_pin *) input spi_ss_n, 
	(* iopad_external_pin *) input spi_sck, 
	(* iopad_external_pin *) input spi_mosi, 
	(* iopad_external_pin *) output spi_miso, 
	(* iopad_external_pin *) output spi_miso_en
	

);

	assign clk_en = 1'b1;

    wire [7:0] rx_data_wire;
    wire       rx_valid_pulse;
    reg  [7:0] tx_data_reg;
    reg cpu_enable;


    always @(posedge clk or negedge rst_n) begin
    		if (!rst_n) begin
        		tx_data_reg <= 8'h00;
    		end else begin
        		tx_data_reg <=debug_r1;
    		end
	end
	
	


	

	
	wire [7:0]  pc_value;
	wire pc_load;
	wire [7:0] address;
	wire pc_inc;

	wire [15:0] instruction_mem_out;
	wire [15:0] instruction;
	wire reset=~rst_n;
	
	pc u_pc(
		.clk(clk),
		.reset(reset),
		
		.inc(pc_inc),
		.load_en(pc_load),
		.load_addr(address),
		.pc_value(pc_value)
	);
	
	
	instruction_memory u_ins_mem(
		.clk(clk),
		.address(pc_value),
		.instruction(instruction_mem_out)
		
		//.prog_write_en(prog_write_en),
		//.prog_addr(prog_addr),
		//.prog_data(prog_data)
	);
	
	wire ir_load;
	instruction_register u_ins_reg(
		.clk(clk),
		.reset(reset),
		
		.load_en(ir_load),
		.ins_in(instruction_mem_out),
		.ins_out(instruction)
	);
	
	wire [3:0] opcode;
	wire [3:0] rd;
	wire [3:0] rs;
	wire [7:0] immediate_data;
	
	Instruction_decoder u_ins_decode(
		.instruction(instruction),
		.opcode(opcode),
		.rd(rd),
		.rs(rs),
		.immediate(immediate_data),
		.address(address)
	);
	
	wire [3:0] alu_op;
	wire zero_flag;
	wire reg_write_en;
	wire mem_write;
	wire mem_read;
	control_unit u_control_unit(
		.clk(clk),
		.reset(reset),
		.opcode(opcode),
		.zero_flag(zero_flag),
		.ir_load(ir_load),
		.pc_inc(pc_inc),
		.pc_load(pc_load),
		.reg_write_en(reg_write_en),
		.mem_write(mem_write),
		.mem_read(mem_read),
		.alu_op(alu_op)
	);
	
	wire [7:0] write_data;
	wire [7:0] reg_a;
	wire [7:0] reg_b;
	wire [7:0] debug_r1;
	
	register u_reg(
		.clk(clk),
		.reset(reset),
		
		.read_addr_1(rd),
		.read_addr_2(rs),
		
		.write_adrr_1(rd),
		.write_data(write_data),
		.write_en(reg_write_en),
		.read_data_1(reg_a),
		.read_data_2(reg_b),
		.debug_r1(debug_r1)
	);
	
	wire [7:0] alu_out;
	parameter LDI   = 4'h1;
	parameter LOAD  = 4'h2;
	parameter STORE = 4'h3;

	
	alu u_alu(
		.reg_a(reg_a),
		.reg_b(reg_b),
		.opcode(alu_op),
		.out(alu_out),
		.zero(zero_flag)
	);
	wire [7:0] mem_data;
	memory u_mem(
		.clk(clk),
		.reset(reset),
		.address(address),
		.write_data(reg_a),
		.write_en(mem_write),
		.read_data(mem_data)
	);
	
	reg [7:0] alu_result_reg;

always @(posedge clk) begin
    if (reset)
        alu_result_reg <= 8'd0;
    else
        alu_result_reg <= alu_out;
end
	assign write_data =(opcode == LDI) ? immediate_data : (opcode == LOAD) ? mem_data : alu_result_reg;
	
    // SPI Target
    spi_target #(
        .CPOL(1'b0),   // Standard Mode 0 (Idle Low)
        .CPHA(1'b0),   // Standard Mode 0 (Sample Rising)
        .WIDTH(8),
        .LSB(1'b0)     // MSB First (Standard)
    ) u_spi_target (
        // System Common
        .i_clk(clk),
        .i_rst_n(rst_n),
        .i_enable(1'b1),        // Enable the module permanently

        // SPI Physical Interface
        .i_ss_n(spi_ss_n),
        .i_sck(spi_sck),
        .i_mosi(spi_mosi),
        .o_miso(spi_miso),
        .o_miso_oe(spi_miso_en),

        // RX Interface (Data FROM MCU)
        .o_rx_data(rx_data_wire),
        .o_rx_data_valid(rx_valid_pulse),

        // TX Interface (Data TO MCU)
        .i_tx_data(tx_data_reg), 
        .o_tx_data_hold()        // Not needed for simple echo
    );

endmodule

