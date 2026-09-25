# 5-Stage Pipelined Processor in VHDL

This repository contains the RTL (Register-Transfer Level) implementation of a 5-stage pipelined processor written in **VHDL**. The system was designed and simulated using Xilinx tools, featuring a complete custom datapath, control unit, and hazard resolution mechanisms.

## System Architecture & Features

* **5-Stage Pipeline:** Implements the classic RISC pipeline stages to maximize instruction throughput:
  * Instruction Fetch (IF)
  * Instruction Decode (ID)
  * Execute (EX)
  * Memory Access (MEM)
  * Write Back (WB)
* **Hazard Resolution:** Includes a dedicated **Forwarding Unit** to detect and resolve data hazards on the fly, minimizing pipeline stalls.
* **Separated Datapath & Control:** Modular design separating the execution units (ALU, registers) from the control logic for better scalability.
* **Memory Initialization:** Utilizes `.mif` and `.coe` files (Distributed ROM) for initializing instruction and data memories.
* **Comprehensive Testing:** Includes individual testbenches (`*tb.vhd`) for all major components and pipeline stages to verify correct behavior during simulation.

## Technologies & Tools
* **Hardware Description Language:** VHDL
* **Development Environment:** Xilinx ISE / Vivado
* **Simulation:** ISim / ModelSim (RTL Simulation)

## Repository Structure
* `*.vhd` files: The core source code for the processor's components (ALU, MUX, Control, Datapath, Pipeline Registers).
* `*tb.vhd` files: The testbenches used for simulating and verifying each module.
* `*.mif` / `*.coe` files: Memory initialization files containing the machine code and initial data.

## How to Run (Simulation)

1. Clone this repository to your local machine:
   ```bash
   git clone [https://github.com/evapantazh/pipelined-processor-vhdl.git](https://github.com/evapantazh/pipelined-processor-vhdl.git)
