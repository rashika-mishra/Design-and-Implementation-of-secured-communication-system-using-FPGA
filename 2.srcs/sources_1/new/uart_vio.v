`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2025 10:58:54
// Design Name: 
// Module Name: uart_vio
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


module uart_vio (
    input clk,   // 200 MHz system clock (modify if needed)
    input rst,   // Active-high reset
    input rx     // UART RX from PC (via USB-UART)
);

    wire [7:0] rx_data;
    wire rx_data_valid;

    // Instantiate your UART receiver
    uart_rx #(
        .BAUD_RATE(115200),
        .CLOCK_FREQ(200_000_000)
    ) uart_inst (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_data(rx_data),
        .rx_data_valid(rx_data_valid)
    );

    // VIO core instance
    vio_0 vio_inst (
        .clk(clk),
        .probe_in0(rx_data),
        .probe_in1(rx_data_valid)
    );

endmodule
