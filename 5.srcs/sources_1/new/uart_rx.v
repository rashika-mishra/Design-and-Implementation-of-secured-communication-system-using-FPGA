module uart_rx #(
    parameter BAUD_RATE = 115200,
    parameter CLOCK_FREQ = 100_000_000
)(
    input clk,
    input rst,
    input rx,
    output reg rx_data_valid,
    output reg [7:0] rx_data
);
    localparam BAUD_COUNT = CLOCK_FREQ / BAUD_RATE;
    reg [15:0] baud_counter = 0;
    reg [3:0] bit_index = 0;
    reg [7:0] shift_reg;
    reg rx_busy = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_data_valid <= 0;
            rx_busy <= 0;
            baud_counter <= 0;
        end else if (!rx_busy && !rx) begin // Detect start bit
            rx_busy <= 1;
            baud_counter <= 0;
            bit_index <= 0;
        end else if (rx_busy) begin
            if (baud_counter < BAUD_COUNT) begin
                baud_counter <= baud_counter + 1;
            end else begin
                baud_counter <= 0;
                if (bit_index < 8)
                    shift_reg[bit_index] <= rx;
                else begin
                    rx_data <= shift_reg;
                    rx_data_valid <= 1;
                    rx_busy <= 0;
                end
                bit_index <= bit_index + 1;
            end
        end else begin
            rx_data_valid <= 0;
        end
    end
endmodule