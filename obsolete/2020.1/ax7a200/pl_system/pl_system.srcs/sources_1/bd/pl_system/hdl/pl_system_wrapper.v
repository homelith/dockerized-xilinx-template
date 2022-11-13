//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1.1_AR75502 (lin64) Build 2960000 Wed Aug  5 22:57:21 MDT 2020
//Date        : Wed May 25 15:30:02 2022
//Host        : hmmt32 running 64-bit Ubuntu 18.04.6 LTS
//Command     : generate_target pl_system_wrapper.bd
//Design      : pl_system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module pl_system_wrapper
   (arst_n,
    clk_100,
    clk_200,
    clk_400,
    hls_gpio,
    mb_gpio_tri_o,
    rtl_gpio);
  input arst_n;
  input clk_100;
  input clk_200;
  input clk_400;
  output [0:0]hls_gpio;
  output [31:0]mb_gpio_tri_o;
  output rtl_gpio;

  wire arst_n;
  wire clk_100;
  wire clk_200;
  wire clk_400;
  wire [0:0]hls_gpio;
  wire [31:0]mb_gpio_tri_o;
  wire rtl_gpio;

  pl_system pl_system_i
       (.arst_n(arst_n),
        .clk_100(clk_100),
        .clk_200(clk_200),
        .clk_400(clk_400),
        .hls_gpio(hls_gpio),
        .mb_gpio_tri_o(mb_gpio_tri_o),
        .rtl_gpio(rtl_gpio));
endmodule
