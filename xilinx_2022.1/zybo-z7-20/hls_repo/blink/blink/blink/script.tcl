############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project blink
set_top blink
add_files src/common.h
add_files src/blink.h
add_files src/blink.cpp
add_files -tb src/blink_tb.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "blink" -flow_target vivado
set_part {xc7z020clg400-1}
create_clock -period 8 -name default
set_clock_uncertainty 0.8
#source "./blink/blink/directives.tcl"
csynth_design
export_design -rtl verilog -format ip_catalog
