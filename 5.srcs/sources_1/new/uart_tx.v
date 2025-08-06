module uart_tx #(
    parameter BAUD_RATE = 115200,
    parameter CLOCK_FREQ = 100_000_000
)(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);
    localparam BAUD_COUNT = CLOCK_FREQ / BAUD_RATE;
    reg [15:0] baud_counter = 0;
    reg [3:0] bit_index = 0;
    reg [9:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_busy <= 0;
            tx <= 1;
            baud_counter <= 0;
        end else if (tx_start && !tx_busy) begin
            shift_reg <= {1'b1, tx_data, 1'b0}; // Stop + Data + Start
            tx_busy <= 1;
            bit_index <= 0;
            baud_counter <= 0;
        end else if (tx_busy) begin
            if (baud_counter < BAUD_COUNT) begin
                baud_counter <= baud_counter + 1;
            end else begin
                baud_counter <= 0;
                tx <= shift_reg[0];
                shift_reg <= {1'b1, shift_reg[9:1]};
                if (bit_index == 9) begin
                    tx_busy <= 0;
                end else begin
                    bit_index <= bit_index + 1;
                end
            end
        end
    end
endmodule
