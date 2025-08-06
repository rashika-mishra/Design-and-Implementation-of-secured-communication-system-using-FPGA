`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2025 10:50:37
// Design Name: 
// Module Name: fpga2_uart_simplex_rx_top
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


module fpga2_uart_simplex_rx_top(
    input clk,
    input rst,
    input uart_rx_pmod,      // From FPGA1 via PMOD
    output UART_txd          // To PC2 via USB-UART (U11)
);

    wire [7:0] rx_data;
    wire rx_data_valid;
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_busy;

    // UART RX from FPGA1 (PMOD)
    uart_rx uart_rx_pmod_inst(
        .clk(clk),
        .rst(rst),
        .rx(uart_rx_pmod),
        .rx_data_valid(rx_data_valid),
        .rx_data(rx_data)
    );

    // UART TX to PC2
    uart_tx uart_tx_pc(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(UART_txd),
        .tx_busy(tx_busy)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start <= 0;
            tx_data <= 8'd0;
        end else begin
            tx_start <= 0;
            if (rx_data_valid && !tx_busy) begin
                tx_data <= rx_data;
                tx_start <= 1;
            end
        end
    end
endmodule
