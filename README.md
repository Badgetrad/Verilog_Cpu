# Verilog Cpu (8-Bit)
This is a custom 8-Bit CPU designed in verilog and implemented in Renasas SLG47910V FPGA(1120 LUTs) on Shrike Lite Development board. Shrike Lite is a development board from Vicharak with an 1120 LUTs and RP2040 MCU. This implementation features 16 bit custom instruction format, with 8 bit register files. Instructions are hardcoded into instruction_memory and a single register storing result is connected to RP2040 MCU via SPI, which can be viewed in Micropython IDE to verify results. 


## Architecture
The CPU follows a Harvard style architecture, with separate instruction and data memories. It consists of a register file, arithmetic logic unit (ALU), control unit, instruction memory and data memory.

The control unit is implemented as a finite state machine (FSM) with the stages Fetch, Decode, Execute, Memory, and Writeback. Instructions are fetched from instruction memory, decoded by the control unit, executed by the ALU, and the results are written back to the register file or memory as required.

The processor supports arithmetic, logical, memory, and control-flow operations through a custom 16-bit instruction set.
