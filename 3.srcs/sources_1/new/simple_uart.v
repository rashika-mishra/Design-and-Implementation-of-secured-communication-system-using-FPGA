    // UART Transmitter Module
    module uart_tx #(parameter BAUD_RATE = 115200, CLOCK_FREQ = 100000000)(
        input clk,
        input rst,
        input tx_start,
        input [7:0] tx_data,
        output reg tx,
        output reg tx_busy);//,
//        output reg [15:0] baud_counter,
//        output reg [3:0] bit_index,
//        output reg [9:0] shift_reg
//    );
        
        localparam BAUD_COUNT =CLOCK_FREQ/BAUD_RATE; //sim_tim=1737*10*Tclk(5ns)+40ns=86890ns
        //localparam BAUD_COUNT = 10416; // for simulation purpose sim_period > 11*10*Tclk + tx_start_tim = 590ns
        
        reg [15:0] baud_counter = 0;
        reg [3:0] bit_index = 0;
        reg [9:0] shift_reg;
        
        always @(posedge clk or posedge rst) begin
            if (rst) begin
                tx_busy <= 0;
                tx <= 1;
                baud_counter <= 0;
            end else if (tx_start && !tx_busy) begin
                shift_reg <= {1'b1, tx_data, 1'b0}; // Start + Data + Stop
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

    // UART Receiver Module
    module uart_rx #(parameter BAUD_RATE = 115200, CLOCK_FREQ = 100000000)(
        input clk,
        input rst,
        input rx,
        output reg rx_data_valid,
        output reg [7:0] rx_data
    );
        
        //localparam BAUD_COUNT = 10416;
       localparam BAUD_COUNT =CLOCK_FREQ/BAUD_RATE;
        reg [15:0] baud_counter = 0;
        reg [3:0] bit_index = 0;
        reg [7:0] shift_reg;
        reg rx_busy = 0;
        
        always @(posedge clk or posedge rst) begin
            if (rst) begin
                rx_data_valid <= 0;
                rx_busy <= 0;
                baud_counter <= 0;
               end 
            
            else if (!rx_busy && !rx) begin // Detect start bit
                rx_busy <= 1;
                baud_counter <= 0;//BAUD_COUNT/2;
                bit_index <= 0;
              end 
              
            else if (rx_busy) begin
                  if (baud_counter < BAUD_COUNT+1) begin
                     baud_counter <= baud_counter + 1;
                    end 
                  
                  else begin
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
            end 
            
            else begin
                  rx_data_valid <= 0;
                 end
        end
    endmodule


// Full-Duplex UART Top Module integrating Transmitter and Receiver
module uart_top #(parameter BAUD_RATE =115200, CLOCK_FREQ = 100000000)(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    input rx,
    output tx,
    output rx_data_valid,
    output [7:0] rx_data,
    output tx_busy
);


    // Instantiate UART Transmitter
    uart_tx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uart_transmitter (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Instantiate UART Receiver
    uart_rx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ)) uart_receiver (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_data_valid(rx_data_valid),
        .rx_data(rx_data)
    );

endmodule
