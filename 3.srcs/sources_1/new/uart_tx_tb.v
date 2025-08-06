`timescale 1ns/1ps

module uart_tx_tb;
    
    parameter BAUD_RATE = 115200;
    parameter CLOCK_FREQ = 200000000;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;
    wire [15:0] baud_counter;
    wire [3:0] bit_index;
    wire [9:0] shift_reg;
    
    
    // Instantiate UART Transmitter
    uart_tx_with_internal_outputs #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .baud_counter(baud_counter),
        .bit_index(bit_index),
        .shift_reg(shift_reg)
    );
    
    // Clock Generation
    always #2.5 clk = ~clk; // 200 MHz clock (5ns period)
    
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;
        
        // Reset sequence
        #20 rst = 0;
        
        // Send Data
        #20 tx_data = 8'hA5; // Send 0xA5
        tx_start = 1;
        #10 tx_start = 0;
        
        // Wait for transmission to complete
        wait(!tx_busy);
        
        // Finish Simulation
        #100 $finish;
    end
    
    // Monitor output
    initial begin
        $monitor("Time=%0t | TX=%b | TX Busy=%b", $time, tx, tx_busy);
    end
endmodule
