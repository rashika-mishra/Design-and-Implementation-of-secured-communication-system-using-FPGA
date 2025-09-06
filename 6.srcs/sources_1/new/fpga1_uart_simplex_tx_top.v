
module fpga1_uart_simplex_tx_top(
    input clk,
    input rst,
    input UART_rxd,            // From PC1 via USB-UART
    output uart_tx_pmod,       // Encrypted to FPGA2 via PMOD
    output UART_txd_enc        // Encrypted to PC1 via USB-UART (monitor)
);

    wire [7:0] rx_data;
    wire rx_data_valid;

    reg [7:0] tx_data_pmod, tx_data_pc;
    reg tx_start_pmod, tx_start_pc;
    wire tx_busy_pmod, tx_busy_pc;
    wire [7:0] encrypted_data;

    // Receive plain data from PC1
    uart_rx uart_rx_pc(
        .clk(clk),
        .rst(rst),
        .rx(UART_rxd),
        .rx_data(rx_data),
        .rx_data_valid(rx_data_valid)
    );

    // Encrypt the received data
    xor_cipher #(.KEY(8'h0f)) encryptor(
        .data_in(rx_data),
        .data_out(encrypted_data)
    );

    // TX encrypted data to FPGA2 (PMOD link)
    uart_tx uart_tx_pmod(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_pmod),
        .tx_data(tx_data_pmod),
        .tx(uart_tx_pmod),
        .tx_busy(tx_busy_pmod)
    );

    // TX encrypted data to PC1 (monitor ciphertext)
    uart_tx uart_tx_pc(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_pc),
        .tx_data(tx_data_pc),
        .tx(UART_txd_enc),
        .tx_busy(tx_busy_pc)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start_pmod <= 0;
            tx_start_pc <= 0;
        end else begin
            tx_start_pmod <= 0;
            tx_start_pc <= 0;

            if (rx_data_valid && !tx_busy_pmod && !tx_busy_pc) begin
                tx_data_pmod <= encrypted_data;
                tx_data_pc <= encrypted_data;
                tx_start_pmod <= 1;
                tx_start_pc <= 1;
            end
        end
    end

endmodule