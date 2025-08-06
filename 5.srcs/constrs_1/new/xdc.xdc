# Clock input from 100 MHz oscillator
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports clk]

# Reset input (using SW0)
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports rst]

## On-board USB-UART for PC connection
#set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {UART_rxd}]  # RX from PC (USB-UART)
#set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {UART_txd}]  # TX to PC (USB-UART)

## PMOD UART for FPGA-to-FPGA connection (example: PMODA pins)
#set_property -dict {PACKAGE_PIN B13 IOSTANDARD LVCMOS33} [get_ports {pmod_tx}]    # PMODA Pin 1 (TX out)
#set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {pmod_rx}]    # PMODA Pin 2 (RX in)

set_property PACKAGE_PIN A13 [get_ports pmod_rx]
set_property PACKAGE_PIN B13 [get_ports pmod_tx]
set_property PACKAGE_PIN V12 [get_ports UART_rxd]
set_property PACKAGE_PIN U11 [get_ports UART_txd]
set_property IOSTANDARD LVCMOS33 [get_ports pmod_rx]
set_property IOSTANDARD LVCMOS33 [get_ports pmod_tx]
set_property IOSTANDARD LVCMOS33 [get_ports UART_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports UART_txd]
