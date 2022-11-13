// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1.1_AR75502 (lin64) Build 2960000 Wed Aug  5 22:57:21 MDT 2020
// Date        : Wed May 25 15:32:44 2022
// Host        : hmmt32 running 64-bit Ubuntu 18.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /opt/work/dockerized/dockerized-xilinx-template/2020.1/ax7a200/pl_system/pl_system.srcs/sources_1/ip/sys_pll/sys_pll_stub.v
// Design      : sys_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module sys_pll(clk_out_400, clk_out_200, clk_out_100, resetn, 
  locked, clk_in1_p, clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_out_400,clk_out_200,clk_out_100,resetn,locked,clk_in1_p,clk_in1_n" */;
  output clk_out_400;
  output clk_out_200;
  output clk_out_100;
  input resetn;
  output locked;
  input clk_in1_p;
  input clk_in1_n;
endmodule
