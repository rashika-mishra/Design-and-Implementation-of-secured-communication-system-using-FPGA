`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2025 11:40:14
// Design Name: 
// Module Name: loopback
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/////////////////////////////// FPGA internal Loopback//////////////////////////////
//  PC(keyboard)--> UART RX(M19)=rx port Verilog design--> tx port Verilog design = UART TX(K24) --> PC(TeraTerm Terminal window)
//////////////////////////////////////////////////////////////////////////////////

module loopback  (
    input clk,
    input rst,
    output tx, // Connect it with TX of FPGA
    input rx // Connect it with RX of FPGA
);
assign tx = rx^1'b1;  // Internal UART Loopback (will get same characters as entered through key board)
endmodule
