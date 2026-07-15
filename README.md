# Verilog Cpu (8-Bit)
This is a custom 8-Bit CPU designed in verilog and implemented in Renasas SLG47910V FPGA(1120 LUTs) on Shrike Lite Development board. Shrike Lite is a development board from Vicharak with an 1120 LUTs and RP2040 MCU. This implementation features 16 bit custom instruction format, with 8 bit register files. Instructions are hardcoded into instruction_memory and a single register storing result is connected to RP2040 MCU via SPI, which can be viewed in Micropython IDE to verify results. 


## Architecture
The CPU follows a Harvard style architecture, with separate instruction and data memories. It consists of a register file, arithmetic logic unit (ALU), control unit, instruction memory and data memory.

The control unit is implemented as a finite state machine (FSM) with the stages Fetch, Decode, Execute, Memory, and Writeback. Instructions are fetched from instruction memory, decoded by the control unit, executed by the ALU, and the results are written back to the register file or memory as required.

The processor supports arithmetic, logical, memory, and control-flow operations through a custom 16-bit instruction set.

## Instruction Set Architecture (ISA)

| Type   | Format                   | Instructions                      |
| ------ | ------------------------ | --------------------------------- |
| R-type | `[opcode][rd][rs][----]` | `ADD`, `SUB`, `AND`, `OR`, `XOR`  |
| I-type | `[opcode][rd][imm8]`     | `LDI`,`LOAD`, `STORE`             |
| S-type | `[opcode][rd][--------]` | `INC`, `DEC`, `NOT`, `SHL`, `SHR` |
| J-type | `[opcode][addr12]`       | `JMP`                             |
| H-type | `[opcode][------------]` | `HLT`                             |

R-type : Register-register operations      
I-type : Immediate and memory operations     
S-type : Single-register operations     
J-type : Jump instructions     
H-type : Halt instruction     

| Instruction      | Opcode | Format                   | Meaning          |
| ---------------- | -----: | ------------------------ | ---------------- |
| `LDI Rd, imm`    |  `0x1` | `[opcode][rd][imm8]`     | `Rd = imm`       |
| `LOAD Rd, addr`  |  `0x2` | `[opcode][rd][addr8]`    | `Rd = mem[addr]` |
| `STORE Rd, addr` |  `0x3` | `[opcode][rd][addr8]`    | `mem[addr] = Rd` |
| `ADD Rd, Rs`     |  `0x4` | `[opcode][rd][rs][----]` | `Rd = Rd + Rs`   |
| `SUB Rd, Rs`     |  `0x5` | `[opcode][rd][rs][----]` | `Rd = Rd - Rs`   |
| `INC Rd`         |  `0x6` | `[opcode][rd][--------]` | `Rd = Rd + 1`    |
| `DEC Rd`         |  `0x7` | `[opcode][rd][--------]` | `Rd = Rd - 1`    |
| `AND Rd, Rs`     |  `0x8` | `[opcode][rd][rs][----]` | `Rd = Rd & Rs`   |
| `OR Rd, Rs`      |  `0x9` | `[opcode][rd][rs][----]` | `Rd = Rd \| Rs`  |
| `XOR Rd, Rs`     |  `0xA` | `[opcode][rd][rs][----]` | `Rd = Rd ^ Rs`   |
| `NOT Rd`         |  `0xB` | `[opcode][rd][--------]` | `Rd = ~Rd`       |
| `SHL Rd`         |  `0xC` | `[opcode][rd][--------]` | `Rd = Rd << 1`   |
| `SHR Rd`         |  `0xD` | `[opcode][rd][--------]` | `Rd = Rd >> 1`   |
| `JMP addr`       |  `0xE` | `[opcode][addr12]`       | `PC = addr`      |
| `HLT`            |  `0xF` | `[opcode][------------]` | Halt execution   |

opcode  : instruction opcode (4 bits)
rd      : destination register (4 bits)
rs      : source register (4 bits)
imm8    : 8-bit immediate
addr8   : 8-bit memory address
address12 : 12-bit jump address

## Future Work

SPI-based instruction loading and programming
Conditional branch instructions (JZ, JNZ)
Pipeline-based execution
Clock stepping and debugging support





