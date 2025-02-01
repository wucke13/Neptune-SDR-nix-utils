# constraints
# ad9361

set_property  -dict {PACKAGE_PIN  N18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_clk_in_p]       ;
set_property  -dict {PACKAGE_PIN  N17  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_frame_in_p]     ;
set_property  -dict {PACKAGE_PIN  P18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_frame_in_n]     ;
set_property  -dict {PACKAGE_PIN  V16  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[0]]   ;
set_property  -dict {PACKAGE_PIN  W16  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[0]]   ;
set_property  -dict {PACKAGE_PIN  Y16  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[1]]   ;
set_property  -dict {PACKAGE_PIN  Y17  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[1]]   ;
set_property  -dict {PACKAGE_PIN  Y18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[2]]   ;
set_property  -dict {PACKAGE_PIN  Y19  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[2]]   ;
set_property  -dict {PACKAGE_PIN  V20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[3]]   ;
set_property  -dict {PACKAGE_PIN  W20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[3]]   ;
set_property  -dict {PACKAGE_PIN  T20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[4]]   ;
set_property  -dict {PACKAGE_PIN  U20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[4]]   ;
set_property  -dict {PACKAGE_PIN  V17  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[5]]   ;
set_property  -dict {PACKAGE_PIN  V18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[5]]   ;
set_property  -dict {PACKAGE_PIN  U18  IOSTANDARD LVDS_25}  [get_ports tx_clk_out_p]                      ;
set_property  -dict {PACKAGE_PIN  U19  IOSTANDARD LVDS_25}  [get_ports tx_clk_out_n]                      ;
set_property  -dict {PACKAGE_PIN  W14  IOSTANDARD LVDS_25}  [get_ports tx_frame_out_p]                    ;
set_property  -dict {PACKAGE_PIN  Y14  IOSTANDARD LVDS_25}  [get_ports tx_frame_out_n]                    ;
set_property  -dict {PACKAGE_PIN  T14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[0]]                  ;
set_property  -dict {PACKAGE_PIN  T15  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[0]]                  ;
set_property  -dict {PACKAGE_PIN  P15  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[1]]                  ;
set_property  -dict {PACKAGE_PIN  P16  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[1]]                  ;
set_property  -dict {PACKAGE_PIN  R16  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[2]]                  ;
set_property  -dict {PACKAGE_PIN  R17  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[2]]                  ;
set_property  -dict {PACKAGE_PIN  U14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[3]]                  ;
set_property  -dict {PACKAGE_PIN  U15  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[3]]                  ;
set_property  -dict {PACKAGE_PIN  V12  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[4]]                  ;
set_property  -dict {PACKAGE_PIN  W13  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[4]]                  ;
set_property  -dict {PACKAGE_PIN  T17  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[5]]                  ;
set_property  -dict {PACKAGE_PIN  R18  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[5]]                  ;

set_property  -dict {PACKAGE_PIN  Y8   IOSTANDARD LVCMOS25} [get_ports gpio_status[0]]                    ;
set_property  -dict {PACKAGE_PIN  Y7   IOSTANDARD LVCMOS25} [get_ports gpio_status[1]]                    ;
set_property  -dict {PACKAGE_PIN  Y6   IOSTANDARD LVCMOS25} [get_ports gpio_status[2]]                    ;
set_property  -dict {PACKAGE_PIN  W8   IOSTANDARD LVCMOS25} [get_ports gpio_status[3]]                    ;
set_property  -dict {PACKAGE_PIN  Y11  IOSTANDARD LVCMOS25} [get_ports gpio_status[4]]                    ;
set_property  -dict {PACKAGE_PIN  V10  IOSTANDARD LVCMOS25} [get_ports gpio_status[5]]                    ;
set_property  -dict {PACKAGE_PIN  W6   IOSTANDARD LVCMOS25} [get_ports gpio_status[6]]                    ;
set_property  -dict {PACKAGE_PIN  V6   IOSTANDARD LVCMOS25} [get_ports gpio_status[7]]                    ;
set_property  -dict {PACKAGE_PIN  W10  IOSTANDARD LVCMOS25} [get_ports gpio_ctl[0]]                       ;
set_property  -dict {PACKAGE_PIN  U5   IOSTANDARD LVCMOS25} [get_ports gpio_ctl[1]]                       ;
set_property  -dict {PACKAGE_PIN  W11  IOSTANDARD LVCMOS25} [get_ports gpio_ctl[2]]                       ;
set_property  -dict {PACKAGE_PIN  Y9   IOSTANDARD LVCMOS25} [get_ports gpio_ctl[3]]                       ;
set_property  -dict {PACKAGE_PIN  T5   IOSTANDARD LVCMOS25} [get_ports enable]                            ;
set_property  -dict {PACKAGE_PIN  V7   IOSTANDARD LVCMOS25} [get_ports txnrx]                             ;
set_property  -dict {PACKAGE_PIN  T9   IOSTANDARD LVCMOS25} [get_ports gpio_en_agc]                       ;
set_property  -dict {PACKAGE_PIN  V8   IOSTANDARD LVCMOS25} [get_ports gpio_sync]                         ;
set_property  -dict {PACKAGE_PIN  U10  IOSTANDARD LVCMOS25} [get_ports gpio_resetb]                       ;

set_property  -dict {PACKAGE_PIN  Y12  IOSTANDARD LVCMOS25  PULLTYPE PULLUP} [get_ports spi_csn]          ;
set_property  -dict {PACKAGE_PIN  U9   IOSTANDARD LVCMOS25} [get_ports spi_clk]                           ;
set_property  -dict {PACKAGE_PIN  U8   IOSTANDARD LVCMOS25} [get_ports spi_mosi]                          ;
set_property  -dict {PACKAGE_PIN  V11  IOSTANDARD LVCMOS25} [get_ports spi_miso]                          ;

# clocks
create_clock -name rx_clk       -period  4 [get_ports rx_clk_in_p]
