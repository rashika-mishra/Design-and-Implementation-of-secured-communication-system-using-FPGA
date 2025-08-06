# Design-and-Implementation-of-secured-communication-system-using-FPGA
# Design and Implementation of a Secured Communication System on FPGA

## Overview

This repository contains source code, simulations, and documentation for the project *"Design and Implementation of a Secured Communication System on FPGA."* The aim is to demonstrate several digital data communication techniques (including security primitives) on a Xilinx Spartan-7 (“Boolean Board”) FPGA using UART—the most common embedded serial standard.

Communication types implemented include:
- Simple loopback
- Simplex
- Full-duplex UART links
- XOR-based security enhancements

All design files (.sv and .xdc), simulation results, and waveform images are provided.

## Table of Contents

- [Importance & Use](#importance--use)
- [Hardware Used](#hardware-used)
- [Project Flow](#project-flow)
  - [UART Loopback Communication (Single FPGA)](#uart-loopback-communication-single-fpga)
  - [UART Loopback Using Separate TX and RX Blocks (Single FPGA)](#uart-loopback-using-separate-tx-and-rx-blocks-single-fpga)
  - [Simplex UART Communication (Two FPGAs)](#simplex-uart-communication-two-fpgas)
  - [Full-Duplex UART Communication (Two FPGAs, PMOD Cross-Connect)](#full-duplex-duplex-uart-communication-two-fpgas-pmod-cross-connect)
  - [Simplex UART with XOR Security](#simplex-uart-with-xor-security)
- [Simulation Results & Images](#simulation-results--images)
- [Acknowledgments](#acknowledgments)
- [Main Objectives](#main-objectives)
- [Significance](#significance)
- [Summary](#summary)

## Importance & Use

- *FPGA-Based Communication:*  
  FPGAs provide real-time, reconfigurable, and hardware-accelerated communication—useful for industry and educational purposes.

- *Security:*  
  Integrating XOR encryption at the hardware level demonstrates the foundation of fast, low-resource cryptographic primitives for embedded and IoT systems.

- *Modular Designs:*  
  All modules (loopback, simplex, duplex, XOR-secured) are designed for adaptability: secure serial links, hardware testability, and teaching digital communication.

## Hardware Used

- *Boolean Spartan-7 Board:*  
  Xilinx Spartan-7 FPGA development board (“Boolean Board”), featuring PMODs, switches, LEDs, and on-board USB-UART for all implementations.

## Project Flow

### UART Loopback Communication (Single FPGA)

*Description:*  
FPGA echoes received serial data back (rx directly looped to tx).  
*Purpose:*  
Basic UART peripheral, cable, and PC terminal setup test.

*Files:*
- uart_loopback_sv.sv: SystemVerilog module (tx = rx logic)
- uart_loopback.xdc: Pin mapping (clock, UART RX/TX)

How to use:  
Send a character from your PC terminal; you receive it back instantly.

---

### UART Loopback Using Separate TX and RX Blocks (Single FPGA)

*Description:*  
Independent transmitter and receiver modules support standard UART frames (start/stop, 8-bit data).  
*Purpose:*  
Demonstrates real UART protocol and parallel data paths.

*Files:*
- uart_tx.sv, uart_rx.sv: Transmitter/Receiver modules
- uart_loopback_parallel.sv: Top module connecting TX and RX
- uart_loopback_parallel.xdc: Constraints for clock, RX, TX pins

How to use:  
Send from PC via USB-UART; character is processed and echoed.

---

### Simplex UART Communication (Two FPGAs)

*Description:*  
One FPGA transmits, the other receives (one-way).  
*Purpose:*  
Demonstrates one-way transfer, shared ground, and board-to-board interfacing.

*Files:*
- simplex_tx.sv, simplex_rx.sv
- simplex_tx.xdc, simplex_rx.xdc

How to use:  
Connect TX of FPGA1 to RX of FPGA2 (+ GND); test with PC data.

---

### Full-Duplex (Duplex) UART Communication (Two FPGAs, PMOD Cross-Connect)

*Description:*  
Both FPGAs send and receive simultaneously, connected via PMODs.  
*Purpose:*  
Demonstrates bi-directional UART.

*Files:*
- uart_full_duplex_bridge.sv
- uart_tx.sv, uart_rx.sv
- duplex.xdc

How to use:  
Each PC sends/receives data through its FPGA in real time.

---

### Simplex UART with XOR Security

*Description:*  
Adds XOR operation with a key for basic encryption/decryption.  
*Purpose:*  
Demonstrates a simple stream cipher for embedded security.

*Files:*
- simplex_xor_tx.sv, simplex_xor_rx.sv
- xor_key.sv (optional)
- simplex_xor.xdc

How to use:  
Data is restored only if the receiver's key matches—shows basic hardware security.

---

## Simulation Results & Images

Simulation testbenches and waveform screenshots are included (.sv, .v, and images) to validate correct operation.

## Acknowledgments

Project based on Xilinx Spartan-7 Boolean FPGA board.  
More info: See Boolean Board Spartan-7 documentation.

## Main Objectives

- *Implement Robust Digital Communication on FPGA:*  
  Design, simulate, and deploy various UART schemes (loopback, simplex, full-duplex).

- *Integrate Security at Hardware Level:*  
  Demonstrate real-time encryption (XOR stream cipher) with hardware implementation.

- *Enable Hardware-Based Protocol Experimentation:*  
  Modular, reusable Verilog/SystemVerilog designs for education, prototyping, and secure embedded communication.

- *Demonstrate Practical Inter-Device Communication:*  
  Facilitate transfer between PCs and FPGAs using UART and PMODs, modeling real-world links.

## Significance

- *Real-Time Security:* Hardware encryption for fast, low-latency, energy-efficient secure communication—critical for embedded and IoT devices.
- *Educational Value:* Illustrates UART basics, clock domain crossing, timing, secure protocol design—ideal for learning.
- *Foundation for Advanced Cryptosystems:* Paves way for more complex cryptography on FPGAs.
- *Testing and Debugging Platform:* A practical platform to test digital/secure comms on real hardware.
- *Versatility:* Modular structure for extension or integration into larger FPGA-based systems.

## Summary

This project teaches and demonstrates secure serial communication using FPGAs, and lays a foundation for secure hardware design in modern embedded/connected systems.

---

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
