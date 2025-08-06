`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 15:22:36
// Design Name: 
// Module Name: uart_tx
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


module uart_tx #(parameter BAUD_RATE = 115200, CLOCK_FREQ = 200000000)(
    input clk,
    input rst,
    input tx_start,              //triggers loading of shift_reg
    input [7:0] tx_data,     
    output reg tx,              //tx is idle (1) on reset
    output reg tx_busy,       //signals an active transmission
        output reg [15:0] baud_counter,
        output reg [3:0] bit_index,
             output reg [9:0] shift_reg
  );
    
    //localparam BAUD_COUNT = CLOCK_FREQ / BAUD_RATE; sim_tim=1737*10*Tclk(5ns)+40ns=86890ns
    localparam BAUD_COUNT = 10; // for simulation purpose sim_period > 11*10*Tclk + tx_start_tim = 590ns
    
    reg [15:0] baud_counter = 0;           // baud_counter ensures the correct baud interval per bit.
    reg [3:0] bit_index = 0;               //bit_index tracks how many bits have been transmitted.
    reg [9:0] shift_reg;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_busy <= 0;
            tx <= 1;
            baud_counter <= 0;
        end 
        else if (tx_start && !tx_busy) begin
            shift_reg <= {1'b1, tx_data, 1'b0}; // Start + Data + Stop
            tx_busy <= 1;
            bit_index <= 0;
            baud_counter <= 0;
        end 
        else if (tx_busy) begin
            if (baud_counter < BAUD_COUNT) begin
                baud_counter <= baud_counter + 1;
            end 
            else begin
                baud_counter <= 0;
                tx <= shift_reg[0];
                shift_reg <= {1'b1, shift_reg[9:1]};
                if (bit_index == 9) begin
                    tx_busy <= 0;
                end 
                else begin
                    bit_index <= bit_index + 1;
                end
            end
        end
    end
endmodule



