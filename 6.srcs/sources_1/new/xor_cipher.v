`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2025 10:06:39
// Design Name: 
// Module Name: xor_cipher
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


module xor_cipher #(
    parameter KEY = 8'h0f // Example key, change as needed
)(
    input  [7:0] data_in,
    output [7:0] data_out
);
    assign data_out = data_in ^ KEY;
endmodule
