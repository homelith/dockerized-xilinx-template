################################################################################
# golden top xdc for RHS Research LiteFury and compatible board
#  - port names are derived from schematic "uEVB.pdf"
################################################################################

################################################################################
# IOSTANDARD for configuration
################################################################################
set_property CFGBVS VCCO [current_design];
set_property CONFIG_VOLTAGE 3.3 [current_design];

################################################################################
# SPI configuration settings
################################################################################
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN Div-1 [current_design];
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design];
set_property CONFIG_MODE SPIx4 [current_design];
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design];
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design];

################################################################################
# clock definition
################################################################################
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVDS_25} [get_ports {DDR_CLK_P}];
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVDS_25} [get_ports {DDR_CLK_N}];
create_clock -period 5 [get_ports {DDR_CLK_P}];

###############################################################################
# SPI configuration Flash ROM (S25FL128SAGBHI210)
###############################################################################
set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS33} [get_ports {S25FL_IO0}];
set_property -dict {PACKAGE_PIN R22 IOSTANDARD LVCMOS33} [get_ports {S25FL_IO1}];
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33} [get_ports {S25FL_IO2}];
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS33} [get_ports {S25FL_IO3}];
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS33} [get_ports {S25FL_CS_N}];
#set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS33} [get_ports {DSC1001_90MHz_CLK}];

################################################################################
# LEDs
################################################################################
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33 PULLUP true DRIVE 8} [get_ports {LED_A1}];
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33 PULLUP true DRIVE 8} [get_ports {LED_A2}];
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33 PULLUP true DRIVE 8} [get_ports {LED_A3}];
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33 PULLUP true DRIVE 8} [get_ports {LED_A4}];
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33 PULLUP true DRIVE 8} [get_ports {LED_M2}];

################################################################################
# PCIe
################################################################################
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33 PULLUP true} [get_ports {PCIE_PERST_N}];
set_false_path -from [get_ports {PCIE_PERST_N}];

set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33 PULLUP true} [get_ports {PCIE_CLKREQ_N}];

set_property -dict {PACKAGE_PIN F6 IOSTANDARD DIFF_SSTL15} [get_ports {PCIE_REFCLK_P}];
set_property -dict {PACKAGE_PIN E6 IOSTANDARD DIFF_SSTL15} [get_ports {PCIE_REFCLK_N}];
create_clock -period 10.000 [get_ports {PCIE_REFCLK_P}];

#set_property PACKAGE_PIN A10 [get_ports {pcie_mgt_rxn[0]}]
#set_property PACKAGE_PIN B10 [get_ports {pcie_mgt_rxp[0]}]
#set_property PACKAGE_PIN A6 [get_ports {pcie_mgt_txn[0]}]
#set_property PACKAGE_PIN B6 [get_ports {pcie_mgt_txp[0]}]
#set_property PACKAGE_PIN A8 [get_ports {pcie_mgt_rxn[1]}]
#set_property PACKAGE_PIN B8 [get_ports {pcie_mgt_rxp[1]}]
#set_property PACKAGE_PIN A4 [get_ports {pcie_mgt_txn[1]}]
#set_property PACKAGE_PIN B4 [get_ports {pcie_mgt_txp[1]}]
#set_property PACKAGE_PIN C11 [get_ports {pcie_mgt_rxn[2]}]
#set_property PACKAGE_PIN D11 [get_ports {pcie_mgt_rxp[2]}]
#set_property PACKAGE_PIN C5 [get_ports {pcie_mgt_txn[2]}]
#set_property PACKAGE_PIN D5 [get_ports {pcie_mgt_txp[2]}]
#set_property PACKAGE_PIN C9 [get_ports {pcie_mgt_rxn[3]}]
#set_property PACKAGE_PIN D9 [get_ports {pcie_mgt_rxp[3]}]
#set_property PACKAGE_PIN C7 [get_ports {pcie_mgt_txn[3]}]
#set_property PACKAGE_PIN D7 [get_ports {pcie_mgt_txp[3]}]

################################################################################
# DDR3 SDRAM
################################################################################
#set_property -dict {PACKAGE_PIN J22 IOSTANDARD SSTL15} [get_ports {DDR3_addr[15]}];
#set_property -dict {PACKAGE_PIN N22 IOSTANDARD SSTL15} [get_ports {DDR3_addr[14]}];
#set_property -dict {PACKAGE_PIN N18 IOSTANDARD SSTL15} [get_ports {DDR3_addr[13]}];
#set_property -dict {PACKAGE_PIN K22 IOSTANDARD SSTL15} [get_ports {DDR3_addr[12]}];
#set_property -dict {PACKAGE_PIN M22 IOSTANDARD SSTL15} [get_ports {DDR3_addr[11]}];
#set_property -dict {PACKAGE_PIN J21 IOSTANDARD SSTL15} [get_ports {DDR3_addr[10]}];
#set_property -dict {PACKAGE_PIN N19 IOSTANDARD SSTL15} [get_ports {DDR3_addr[9]}];
#set_property -dict {PACKAGE_PIN M20 IOSTANDARD SSTL15} [get_ports {DDR3_addr[8]}];
#set_property -dict {PACKAGE_PIN N20 IOSTANDARD SSTL15} [get_ports {DDR3_addr[7]}];
#set_property -dict {PACKAGE_PIN M21 IOSTANDARD SSTL15} [get_ports {DDR3_addr[6]}];
#set_property -dict {PACKAGE_PIN M18 IOSTANDARD SSTL15} [get_ports {DDR3_addr[5]}];
#set_property -dict {PACKAGE_PIN K21 IOSTANDARD SSTL15} [get_ports {DDR3_addr[4]}];
#set_property -dict {PACKAGE_PIN L18 IOSTANDARD SSTL15} [get_ports {DDR3_addr[3]}];
#set_property -dict {PACKAGE_PIN M16 IOSTANDARD SSTL15} [get_ports {DDR3_addr[2]}];
#set_property -dict {PACKAGE_PIN L21 IOSTANDARD SSTL15} [get_ports {DDR3_addr[1]}];
#set_property -dict {PACKAGE_PIN M15 IOSTANDARD SSTL15} [get_ports {DDR3_addr[0]}];

#set_property -dict {PACKAGE_PIN L20 IOSTANDARD SSTL15} [get_ports {DDR3_ba[2]}];
#set_property -dict {PACKAGE_PIN J20 IOSTANDARD SSTL15} [get_ports {DDR3_ba[1]}];
#set_property -dict {PACKAGE_PIN L19 IOSTANDARD SSTL15} [get_ports {DDR3_ba[0]}];
#set_property -dict {PACKAGE_PIN K18 IOSTANDARD SSTL15} [get_ports {DDR3_cas_n}];
#set_property -dict {PACKAGE_PIN K17 IOSTANDARD DIFF_SSTL15} [get_ports {DDR3_ck_p}];
#set_property -dict {PACKAGE_PIN J17 IOSTANDARD DIFF_SSTL15} [get_ports {DDR3_ck_n}];
#set_property -dict {PACKAGE_PIN H22 IOSTANDARD SSTL15} [get_ports {DDR3_cke}];
#set_property -dict {PACKAGE_PIN xxx IOSTANDARD SSTL15} [get_ports {DDR3_cs_n}]; # always enabled

#set_property -dict {PACKAGE_PIN G11 IOSTANDARD SSTL15} [get_ports {DDR3_dm[1]}];
#set_property -dict {PACKAGE_PIN A19 IOSTANDARD SSTL15} [get_ports {DDR3_dm[0]}];
#set_property -dict {PACKAGE_PIN D22 IOSTANDARD SSTL15} [get_ports {DDR3_dq[15]}];
#set_property -dict {PACKAGE_PIN B22 IOSTANDARD SSTL15} [get_ports {DDR3_dq[14]}];
#set_property -dict {PACKAGE_PIN D21 IOSTANDARD SSTL15} [get_ports {DDR3_dq[13]}];
#set_property -dict {PACKAGE_PIN C22 IOSTANDARD SSTL15} [get_ports {DDR3_dq[12]}];
#set_property -dict {PACKAGE_PIN E21 IOSTANDARD SSTL15} [get_ports {DDR3_dq[11]}];
#set_property -dict {PACKAGE_PIN D20 IOSTANDARD SSTL15} [get_ports {DDR3_dq[10]}];
#set_property -dict {PACKAGE_PIN G21 IOSTANDARD SSTL15} [get_ports {DDR3_dq[9]}];
#set_property -dict {PACKAGE_PIN E22 IOSTANDARD SSTL15} [get_ports {DDR3_dq[8]}];
#set_property -dict {PACKAGE_PIN C18 IOSTANDARD SSTL15} [get_ports {DDR3_dq[7]}];
#set_property -dict {PACKAGE_PIN F20 IOSTANDARD SSTL15} [get_ports {DDR3_dq[6]}];
#set_property -dict {PACKAGE_PIN C19 IOSTANDARD SSTL15} [get_ports {DDR3_dq[5]}];
#set_property -dict {PACKAGE_PIN F19 IOSTANDARD SSTL15} [get_ports {DDR3_dq[4]}];
#set_property -dict {PACKAGE_PIN A20 IOSTANDARD SSTL15} [get_ports {DDR3_dq[3]}];
#set_property -dict {PACKAGE_PIN E19 IOSTANDARD SSTL15} [get_ports {DDR3_dq[2]}];
#set_property -dict {PACKAGE_PIN B20 IOSTANDARD SSTL15} [get_ports {DDR3_dq[1]}];
#set_property -dict {PACKAGE_PIN D19 IOSTANDARD SSTL15} [get_ports {DDR3_dq[0]}];

#set_property -dict {PACKAGE_PIN B21 IOSTANDARD DIFF_SSTL15} [get_ports {DDR3_dqs_p[1]}];
#set_property -dict {PACKAGE_PIN A21 IOSTANDARD DIFF_SSTL15} [get_ports {DDR3_dqs_n[1]}];
#set_property -dict {PACKAGE_PIN F18 IOSTANDARD DIFF_SSTL15} [get_ports {DDR3_dqs_p[0]}];
#set_property -dict {PACKAGE_PIN E18 IOSTANDARD DIFF_SSTL15} [get_ports {DDR3_dqs_n[0]}];

#set_property -dict {PACKAGE_PIN K19 IOSTANDARD SSTL15} [get_ports {DDR3_odt}];
#set_property -dict {PACKAGE_PIN H20 IOSTANDARD SSTL15} [get_ports {DDR3_ras_n}];
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS15} [get_ports {DDR3_reset_n}];
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD SSTL15} [get_ports {DDR3_we_n}];
