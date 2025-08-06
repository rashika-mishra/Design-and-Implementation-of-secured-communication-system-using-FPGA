`timescale 1ns / 1ps

module uart_fpga_echo #(parameter BAUD_RATE = 115200, CLOCK_FREQ = 100000000)(
    input clk,              // 50MHz clock on Spartan-7
    input rst,              // Push-button or reset signal
    input uart_rx_pin,      // FTDI TX → FPGA RX
    output uart_tx_pin      // FPGA TX → FTDI RX
);

    // Internal wires and registers
    wire [7:0] rx_data;
    wire rx_data_valid;
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_busy;

    // UART Receiver instantiation
    uart_rx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uart_receiver (
        .clk(clk),
        .rst(rst),
        .rx(uart_rx_pin),
        .rx_data_valid(rx_data_valid),
        .rx_data(rx_data)
    );

    // UART Transmitter instantiation
    uart_tx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uart_transmitter (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(uart_tx_pin),
        .tx_busy(tx_busy)
    );

    // Simple state machine to echo back received bytes
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start <= 0;
            tx_data <= 8'd0;
        end else begin
            tx_start <= 0;  // default

            if (rx_data_valid && !tx_busy) begin
                tx_data <= rx_data;
                tx_start <= 1;  // send back the received byte
            end
        end
    end

endmodule
