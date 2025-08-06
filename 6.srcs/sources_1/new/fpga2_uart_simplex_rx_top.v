`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2025 10:05:48
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
    input uart_rx_pmod,         // Encrypted input from FPGA1
    output UART_txd_dec,        // Decrypted to PC2
    output UART_txd_enc         // Encrypted to PC2 (monitor)
);

    wire [7:0] rx_data;
    wire rx_data_valid;

    reg [7:0] tx_data_dec, tx_data_enc;
    reg tx_start_dec, tx_start_enc;
    wire tx_busy_dec, tx_busy_enc;
    wire [7:0] decrypted_data;

    // RX encrypted data from PMOD
    uart_rx uart_rx_pmod_inst(
        .clk(clk),
        .rst(rst),
        .rx(uart_rx_pmod),
        .rx_data(rx_data),
        .rx_data_valid(rx_data_valid)
    );

    // Decrypt
    xor_cipher #(.KEY(8'h0f)) decryptor(
        .data_in(rx_data),
        .data_out(decrypted_data)
    );

    // TX decrypted data to PC2
    uart_tx uart_tx_dec(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_dec),
        .tx_data(tx_data_dec),
        .tx(UART_txd_dec),
        .tx_busy(tx_busy_dec)
    );

    // TX encrypted data to PC2 for monitoring
    uart_tx uart_tx_enc(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_enc),
        .tx_data(tx_data_enc),
        .tx(UART_txd_enc),
        .tx_busy(tx_busy_enc)
    );

       always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start_dec <= 0;
            tx_start_enc <= 0;
            tx_data_dec <= 8'd0;
            tx_data_enc <= 8'd0;
        end else begin
            // Default: keep tx_start LOW
            tx_start_dec <= 0;
            tx_start_enc <= 0;

            if (rx_data_valid && !tx_busy_dec && !tx_busy_enc) begin
                tx_data_dec <= decrypted_data;
                tx_data_enc <= rx_data;
                tx_start_dec <= 1;
                tx_start_enc <= 1;
            end
        end
    end


endmodule

