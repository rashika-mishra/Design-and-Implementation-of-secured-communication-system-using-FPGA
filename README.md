# Design-and-Implementation-of-secured-communication-system-using-FPGA
This project is designed to implement UART communication using FPGA and vivado
Overview
This repository contains source code, simulations, and documentation for the project “Design and Implementation of a Secured Communication System on FPGA.”
The aim is to demonstrate several digital data communication techniques (including security primitives) on a Xilinx Spartan-7 (Boolean) FPGA board using UART—the most common embedded serial standard.

Communication types implemented include simple loopback, simplex, and full-duplex UART links, as well as an XOR-based security enhancement, with all design files (.sv and .xdc), simulation results, and waveform images provided.

Importance & Use
FPGA-Based Communication: FPGAs provide real-time, reconfigurable and hardware-accelerated communication—suitable for learning and in industry.

Security: Integrating XOR encryption at the hardware level demonstrates the foundation of fast, low-resource cryptographic primitives for embedded and IoT systems.

Modular Designs: The included modules (loopback, simplex, duplex, XOR-based) can be adapted for various practical uses: secure serial links, testability of hardware, and teaching digital communication fundamentals.

Hardware Used
Boolean Spartan-7 Board:
A Xilinx Spartan-7 FPGA development board (often called “Boolean Board,” with PMODs, switches, LEDs, on-board USB-UART) is used for all implementations, chosen for its versatility, educational support, and abundant GPIO.

Project Flow
Below is the stepwise flow with brief explanations of each design block and included files:

1. UART Loopback Communication (Single FPGA)
Description: FPGA echoes received serial data back—rx is directly looped to tx.

Purpose: Basic test of UART peripheral, cable, and PC terminal setup.

Files:

uart_loopback_sv.sv: SystemVerilog module where tx = rx logic is implemented.

uart_loopback.xdc: Pin mapping for clock, UART RX/TX.

How to use: Send a character from your PC terminal; you receive it back instantly. Useful for basic debugging.

2. UART Loopback using Separate TX and RX Blocks (Single FPGA)
Description: Implements independent transmitter and receiver modules supporting standard UART frames (start/stop bits, 8-bit data).

Purpose: Demonstrates real UART protocol and parallelizing data for transmit and receive paths.

Files:

uart_tx.sv, uart_rx.sv: Transmitter/Receiver modules.

uart_loopback_parallel.sv: Top module connecting TX and RX.

uart_loopback_parallel.xdc: Constraints for clock, RX, TX pins.

How to use: Connect your PC via USB-UART; characters are sent through RX path and echoed back via TX with protocol handling.

3. Simplex UART Communication (Two FPGAs)
Description: One FPGA acts as transmitter and another as receiver, with one-way (simplex) data flow using UART protocol.

Purpose: Demonstrates one-way data transfer and the need for shared ground; shows board-to-board digital interfacing.

Files:

simplex_tx.sv, simplex_rx.sv: Top modules for transmitter/receiver FPGAs.

simplex_tx.xdc, simplex_rx.xdc: Pin assignments (using PMOD/GPIO for TX, RX).

How to use: Connect TX of FPGA1 to RX of FPGA2 (and GND), and test with data sent from one PC; verify reception on the other.

4. Full-Duplex (Duplex) UART Communication (Two FPGAs, PMOD Cross-Connect)
Description: Both FPGAs send and receive simultaneously; both are connected to their own PC via USB-UART and to each other via PMOD cross-connect (TX↔RX, GND↔GND).

Purpose: Demonstrates bi-directional UART, more realistic of real-world hardware links.

Files:

uart_full_duplex_bridge.sv: Top module that bridges PC↔FPGA and FPGA↔FPGA.

uart_tx.sv, uart_rx.sv: UART building blocks.

duplex.xdc: Pin mapping for clock, RX/TX, PMOD signals for both boards.

How to use: Each PC can send to and receive from the other in real time via the FPGAs.

5. Simplex UART with XOR Security
Description: Adds an XOR operation between data and a security key before transmission, and removes it after reception (decrypt).

Purpose: Demonstrates basic stream cipher operation for embedded security.

Files:

simplex_xor_tx.sv, simplex_xor_rx.sv: Modules for TX and RX with XOR security.

xor_key.sv (optional): Key generator module.

simplex_xor.xdc: Constraints for PMOD or GPIO for secured transmission.

How to use: Only with the correct key at receiver, the original data is restored—demonstrates fundamental security in hardware.

6. Simulation Results & Images
Simulation testbenches and waveform screenshots are provided for each design (*.sv, .v, and image).

Images help validate the correct operation and can be used for documentation or as reference for your own tests.

Acknowledgments
Project based on a Xilinx Spartan-7 Boolean FPGA board.

For more information about the board, see Boolean Board Spartan-7 documentation.

Main Objectives
Implement Robust Digital Communication on FPGA

Design, simulate, and deploy various UART-based serial communication schemes (loopback, simplex, full-duplex) on a hardware platform (Spartan-7 FPGA).

Integrate Security at the Hardware Level

Demonstrate simple encryption (e.g., XOR cipher) in real-time UART communication to show how FPGAs can provide secure data exchange at the hardware layer.

Enable Hardware-Based Protocol Experimentation

Create modular, reusable Verilog/SystemVerilog designs that can be applied to educational, prototyping, or embedded-security environments.

Demonstrate Practical Inter-Device Communication

Facilitate data transfer between PCs and between multiple FPGAs using UART and external connections (e.g., PMODs), as a model for secure and reliable system-to-system links.

Significance
Real-Time Security: Implementing encryption on FPGAs demonstrates how hardware can achieve fast, low-latency, and energy-efficient secure communication, critical for embedded and IoT devices.

Educational Value: The project illustrates not just UART basics but also principles of clock domain crossing, hardware timing, and secure protocol design, making it ideal for learning and teaching.

Foundation for Advanced Cryptosystems: The approach shows how simple hardware security features can be integrated—and paves the way for implementing more complex cryptographic algorithms in reconfigurable hardware.

Testing and Debugging Platform: Gives engineers and students a practical, observable way to test digital communication and security protocols on real hardware, bridging the gap between theory and implementation.

Versatility: The modular structure allows for extension to other protocols, more advanced encryption, or integration into larger FPGA-based systems.

In summary:
This project not only teaches and demonstrates secure serial communication using FPGAs, but also lays critical groundwork for secure hardware design in modern embedded and connected systems.
