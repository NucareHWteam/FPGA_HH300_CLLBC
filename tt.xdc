set_property PACKAGE_PIN P17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property IOSTANDARD LVCMOS33 [get_ports w_TX_SERIAL]
set_property IOSTANDARD LVCMOS33 [get_ports r_RX_SERIAL]

set_property PACKAGE_PIN V17 [get_ports w_TX_SERIAL]
set_property PACKAGE_PIN U16 [get_ports r_RX_SERIAL]

set_property IOSTANDARD LVCMOS33 [get_ports eeprom_cs_n]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_miso]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_mosi]

set_property PACKAGE_PIN K1 [get_ports eeprom_cs_n]
set_property PACKAGE_PIN F3 [get_ports eeprom_sclk]
set_property PACKAGE_PIN J2 [get_ports eeprom_miso]
set_property PACKAGE_PIN J3 [get_ports eeprom_mosi]






set_property MARK_DEBUG false [get_nets r_TX_DV_reg_n_0]
set_property MARK_DEBUG false [get_nets i_clk_wiz_0/clk_out2]


set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]




set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[0]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[1]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[2]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[3]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[4]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[5]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[6]}]
set_property MARK_DEBUG false [get_nets {i_UART_TX/i_TX_Byte[7]}]




set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {m_dout[7]}]




#set_property IOSTANDARD LVCMOS33 [get_ports mosi_2]
#set_property PACKAGE_PIN U18 [get_ports miso_2]


set_property PACKAGE_PIN P15 [get_ports sclk]
set_property IOSTANDARD LVCMOS33 [get_ports sclk]
set_property PACKAGE_PIN U12 [get_ports mosi]
set_property IOSTANDARD LVCMOS33 [get_ports mosi]
set_property PACKAGE_PIN V12 [get_ports {cs_n[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cs_n[0]}]




set_property PACKAGE_PIN F5 [get_ports {m_dout[0]}]
set_property PACKAGE_PIN C6 [get_ports {m_dout[1]}]
set_property PACKAGE_PIN B7 [get_ports {m_dout[3]}]
set_property PACKAGE_PIN C5 [get_ports {m_dout[2]}]
set_property PACKAGE_PIN B6 [get_ports {m_dout[4]}]
set_property PACKAGE_PIN A6 [get_ports {m_dout[5]}]
set_property PACKAGE_PIN A5 [get_ports {m_dout[6]}]
set_property PACKAGE_PIN D8 [get_ports {m_dout[7]}]






set_property IOSTANDARD LVCMOS18 [get_ports {VAUXP[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXN[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXP[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXN[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXP[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXN[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXP[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {VAUXN[3]}]

set_property IOSTANDARD LVCMOS18 [get_ports clk_ADC_p]
set_property PACKAGE_PIN T5 [get_ports clk_ADC_p]
set_property IOSTANDARD LVCMOS18 [get_ports ADC_CLK_OUT_P]
set_property IOSTANDARD LVCMOS18 [get_ports ADC_CLK_OUT_N]
set_property PACKAGE_PIN N5 [get_ports ADC_CLK_OUT_P]
set_property PACKAGE_PIN P5 [get_ports ADC_CLK_OUT_N]

set_property IOSTANDARD LVCMOS18 [get_ports {ADC_value[*]}]
set_property PACKAGE_PIN U8 [get_ports {ADC_value[0]}]
set_property PACKAGE_PIN V7 [get_ports {ADC_value[1]}]
set_property PACKAGE_PIN U7 [get_ports {ADC_value[2]}]
set_property PACKAGE_PIN V6 [get_ports {ADC_value[3]}]
set_property PACKAGE_PIN U6 [get_ports {ADC_value[4]}]
set_property PACKAGE_PIN V5 [get_ports {ADC_value[5]}]
set_property PACKAGE_PIN V4 [get_ports {ADC_value[6]}]
set_property PACKAGE_PIN U4 [get_ports {ADC_value[7]}]
set_property PACKAGE_PIN U3 [get_ports {ADC_value[8]}]
set_property PACKAGE_PIN V2 [get_ports {ADC_value[9]}]
set_property PACKAGE_PIN U2 [get_ports {ADC_value[10]}]
set_property PACKAGE_PIN V1 [get_ports {ADC_value[11]}]

set_property IOSTANDARD LVCMOS18 [get_ports ADC_ORT]
set_property PACKAGE_PIN R1 [get_ports ADC_ORT]


set_property PACKAGE_PIN T15 [get_ports sclk_2]
set_property IOSTANDARD LVCMOS33 [get_ports sclk_2]

set_property PACKAGE_PIN V11 [get_ports {cs_n_2[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cs_n_2[0]}]

set_property PACKAGE_PIN V10 [get_ports mosi_2]
set_property IOSTANDARD LVCMOS33 [get_ports mosi_2]

set_property DIFF_TERM FALSE [get_ports clk]

set_property PACKAGE_PIN U13 [get_ports LED_Blue]
set_property IOSTANDARD LVCMOS33 [get_ports LED_Blue]
set_property PACKAGE_PIN T13 [get_ports LED_Green]
set_property IOSTANDARD LVCMOS33 [get_ports LED_Green]

set_property PACKAGE_PIN R18 [get_ports LED_Red]
set_property IOSTANDARD LVCMOS33 [get_ports LED_Red]

#set_property PULLUP true [get_ports LED_Blue]
#set_property PULLUP true [get_ports w_TX_SERIAL_Bat]



set_property PULLUP true [get_ports {cs_n_2[0]}]

set_property PULLUP true [get_ports mosi_2]
#set_property PULLUP true [get_ports miso_2]
set_property PULLUP true [get_ports sclk_2]

set_property IOSTANDARD LVCMOS33 [get_ports adc_sda]
set_property IOSTANDARD LVCMOS33 [get_ports adc_scl]

set_property PACKAGE_PIN M17 [get_ports adc_sda]
set_property PACKAGE_PIN R17 [get_ports adc_scl]


set_property PACKAGE_PIN U14 [get_ports cpu_detect]
set_property IOSTANDARD LVCMOS33 [get_ports cpu_detect]
set_property PULLUP true [get_ports cpu_detect]

set_property PACKAGE_PIN V14 [get_ports mpu_Power_Kill]
set_property IOSTANDARD LVCMOS33 [get_ports mpu_Power_Kill]
#set_property PULLDOWN true [get_ports cpu_phold]

#set_property IOSTANDARD LVCMOS33 [get_ports test1]
#set_property IOSTANDARD LVCMOS33 [get_ports test2]
set_property IOSTANDARD LVCMOS33 [get_ports fpga_awake]
set_property IOSTANDARD LVCMOS33 [get_ports pin_Trig_signal]

set_property PACKAGE_PIN N14 [get_ports fpga_awake]
set_property PACKAGE_PIN P14 [get_ports pin_Trig_signal]



set_property IOSTANDARD LVCMOS33 [get_ports Neutron_Domino]
set_property PACKAGE_PIN T9 [get_ports Neutron_Domino]

#set_property IOSTANDARD LVCMOS33 [get_ports VP]
#set_property PACKAGE_PIN A13 [get_ports VP]
#set_property IOSTANDARD LVCMOS33 [get_ports VN]
#set_property PACKAGE_PIN A14 [get_ports VN]
#create_debug_core u_ila_0 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property port_width 1 [get_debug_ports u_ila_0/clk]
#connect_debug_port u_ila_0/clk [get_nets [list clk_uart]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#set_property port_width 1 [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list i_RX_Serial]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#set_property port_width 1 [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list w_TX_SERIAL_OBUF]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets clk_uart]










connect_debug_port u_ila_0/probe6 [get_nets [list {Ch_1460Kev_write[0]} {Ch_1460Kev_write[1]} {Ch_1460Kev_write[2]} {Ch_1460Kev_write[3]} {Ch_1460Kev_write[4]} {Ch_1460Kev_write[5]} {Ch_1460Kev_write[6]} {Ch_1460Kev_write[7]} {Ch_1460Kev_write[8]} {Ch_1460Kev_write[9]} {Ch_1460Kev_write[10]} {Ch_1460Kev_write[11]} {Ch_1460Kev_write[12]} {Ch_1460Kev_write[13]} {Ch_1460Kev_write[14]} {Ch_1460Kev_write[15]}]]








connect_debug_port u_ila_0/probe0 [get_nets [list {i_ADC_invert/temp[0]} {i_ADC_invert/temp[1]} {i_ADC_invert/temp[2]} {i_ADC_invert/temp[3]} {i_ADC_invert/temp[4]} {i_ADC_invert/temp[5]} {i_ADC_invert/temp[6]} {i_ADC_invert/temp[7]} {i_ADC_invert/temp[8]} {i_ADC_invert/temp[9]} {i_ADC_invert/temp[10]} {i_ADC_invert/temp[11]}]]






















