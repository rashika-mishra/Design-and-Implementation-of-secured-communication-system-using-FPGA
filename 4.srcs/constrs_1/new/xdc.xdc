# Clock input from 100 MHz oscillator
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {clk}]

# Reset input (using SW0)
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {rst}]

# PMOD RX input from FPGA1 (choose a PMOD pin, e.g., F5)
set_property -dict {PACKAGE_PIN B13  IOSTANDARD LVCMOS33} [get_ports {uart_rx_pmod}]

# On-board USB-UART TX to PC2
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {UART_txd}]