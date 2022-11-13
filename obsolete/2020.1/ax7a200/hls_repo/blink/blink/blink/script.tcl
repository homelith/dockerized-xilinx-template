############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project blink
set_top blink
add_files src/common.h
add_files src/blink.h
add_files src/blink.cpp
add_files -tb src/blink_tb.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "blink"
set_part {xc7a200tfbg484-2}
create_clock -period 5.0 -name default
config_sdx -target none
config_export -format ip_catalog -rtl verilog -vivado_optimization_level 2 -vivado_phys_opt place -vivado_report_level 0
set_clock_uncertainty 5.0%
#source "./blink/blink/directives.tcl"
csynth_design
export_design -rtl verilog -format ip_catalog
