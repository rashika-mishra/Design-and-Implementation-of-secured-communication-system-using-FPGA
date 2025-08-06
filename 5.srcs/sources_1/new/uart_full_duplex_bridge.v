`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2025 15:12:11
// Design Name: 
// Module Name: uart_full_duplex_bridge
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


module uart_full_duplex_bridge(
    input clk,
    input rst,
    input UART_rxd,         // From PC (V12)
    output UART_txd,        // To PC (U11)
    input pmod_rx,          // From other FPGA PMOD TX
    output pmod_tx          // To other FPGA PMOD RX
);

    // RX from PC
    wire [7:0] rx_data_pc;
    wire rx_data_valid_pc;
    uart_rx uart_rx_pc(
        .clk(clk),
        .rst(rst),
        .rx(UART_rxd),
        .rx_data_valid(rx_data_valid_pc),
        .rx_data(rx_data_pc)
    );

    // RX from FPGA (PMOD)
    wire [7:0] rx_data_pmod;
    wire rx_data_valid_pmod;
    uart_rx uart_rx_pmod(
        .clk(clk),
        .rst(rst),
        .rx(pmod_rx),
        .rx_data_valid(rx_data_valid_pmod),
        .rx_data(rx_data_pmod)
    );

    // TX to FPGA (PMOD)
    reg [7:0] tx_data_pmod;
    reg tx_start_pmod;
    wire tx_busy_pmod;
    uart_tx uart_tx_pmod(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_pmod),
        .tx_data(tx_data_pmod),
        .tx(pmod_tx),
        .tx_busy(tx_busy_pmod)
    );

    // TX to PC
    reg [7:0] tx_data_pc;
    reg tx_start_pc;
    wire tx_busy_pc;
    uart_tx uart_tx_pc(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_pc),
        .tx_data(tx_data_pc),
        .tx(UART_txd),
        .tx_busy(tx_busy_pc)
    );

    // Forward PC→FPGA
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start_pmod <= 0;
            tx_data_pmod <= 8'd0;
        end else begin
            tx_start_pmod <= 0;
            if (rx_data_valid_pc && !tx_busy_pmod) begin
                tx_data_pmod <= rx_data_pc;
                tx_start_pmod <= 1;
            end
        end
    end

    // Forward FPGA→PC
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start_pc <= 0;
            tx_data_pc <= 8'd0;
        end else begin
            tx_start_pc <= 0;
            if (rx_data_valid_pmod && !tx_busy_pc) begin
                tx_data_pc <= rx_data_pmod;
                tx_start_pc <= 1;
            end
        end
    end

endmodule