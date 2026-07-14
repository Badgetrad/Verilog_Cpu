`timescale 1ns/1ps

module top_tb;

    // Inputs

    reg clk;
    reg rst_n;

    reg spi_ss_n;
    reg spi_sck;
    reg spi_mosi;

    // Outputs

    wire clk_en;

    wire spi_miso;
    wire spi_miso_en;



    // Instantiate DUT

    top uut (

        .clk(clk),
        .clk_en(clk_en),

        .rst_n(rst_n),

        .spi_ss_n(spi_ss_n),
        .spi_sck(spi_sck),
        .spi_mosi(spi_mosi),

        .spi_miso(spi_miso),
        .spi_miso_en(spi_miso_en)

    );

    // 50 MHz clock

    initial begin

        clk = 0;

        forever #10 clk = ~clk;

    end

    // Reset + idle SPI

    initial begin

        rst_n = 0;

        spi_ss_n = 1;
        spi_sck  = 0;
        spi_mosi = 0;

        #100;

        rst_n = 1;

        #5000;

        $finish;

    end

    // Dump waves

    initial begin

        $dumpfile("cpu.vcd");
        $dumpvars(0, top_tb);
	

    end



//always @(posedge clk)
initial begin
    #500 
        $display(
            "A=%d B=%d ALU=%d WE=%b",
            uut.u_reg.mem[1],
            uut.u_reg.mem[2],
            uut.u_mem.mem[10],
            uut.reg_write_en
        );
    
end

endmodule