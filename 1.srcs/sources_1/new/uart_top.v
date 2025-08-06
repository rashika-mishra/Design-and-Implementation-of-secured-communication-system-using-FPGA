`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 15:23:34
// Design Name: 
// Module Name: uart_top
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

// Full-Duplex UART Top Module integrating Transmitter and Receiver
module uart_top #(parameter BAUD_RATE = 115200, CLOCK_FREQ = 200000000)(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    input rx,
    output tx,
    output rx_data_valid,
    output [7:0] rx_data,
    output tx_busy
);


    // Instantiate UART Transmitter
    uart_tx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uart_transmitter (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Instantiate UART Receiver
    uart_rx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uart_receiver (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_data_valid(rx_data_valid),
        .rx_data(rx_data)
    );

endmodule

