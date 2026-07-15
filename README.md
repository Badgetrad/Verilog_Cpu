# Verilog Cpu (8-Bit)
This is a custom 8-Bit CPU designed in verilog and implemented in Renasas SLG47910V FPGA(1120 LUTs) on Shrike Lite Development board. Shrike Lite is a development board with an 1120 LUTs and RP2040 MCU. This implementation features 16 bit custom instruction format, with 8 bit register files. Instructions are hardcoded into instruction_memory and a single register storing result is connected to RP2040 MCU via SPI, which can be viewed in Micropython IDE. 

## Features
