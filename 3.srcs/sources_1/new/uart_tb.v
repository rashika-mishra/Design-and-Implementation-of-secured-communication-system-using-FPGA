`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2025 06:37:08 PM
// Design Name: 
// Module Name: uart_tb
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

// UART Testbench
`timescale 1ns/1ps

module uart_tb;
    
    parameter BAUD_RATE = 115200;
    parameter CLOCK_FREQ = 200000000;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire rx_data_valid;
    wire [7:0] rx_data;
    wire tx_busy;
    
    // Instantiate UART Top Module
    uart_top #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .rx(tx), // Loopback TX to RX
        .tx(tx),
        .rx_data_valid(rx_data_valid),
        .rx_data(rx_data),
        .tx_busy(tx_busy)
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
        
        // Transmit Data
        #20 tx_data = 8'hA5; // Send 0xA5
        tx_start = 1;
        #10 tx_start = 0;
        
        // Wait for transmission and reception
        wait(rx_data_valid);
        
        // Display Received Data
        $display("Received Data: %h", rx_data);
        
        #600;
 
         // Transmit Data
        #20 tx_data = 8'hB5; // Send 0xB5
        tx_start = 1;
        #10 tx_start = 0;
        
        // Wait for transmission and reception
        wait(rx_data_valid);
        
        // Display Received Data
        $display("Received Data: %h", rx_data);
        
        
               // Finish Simulation
        #100 $finish;
    end
    
    // Monitor output
    initial begin
        $monitor("Time=%0t | TX=%b | RX=%b | RX Data=%h | RX Valid=%b", $time, tx, uut.rx, rx_data, rx_data_valid);
    end
endmodule
