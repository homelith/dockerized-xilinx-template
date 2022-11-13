//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
//Date        : Thu Feb 17 07:46:43 2022
//Host        : hmmt32 running 64-bit Ubuntu 18.04.6 LTS
//Command     : generate_target pl_system_wrapper.bd
//Design      : pl_system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module pl_system_wrapper(
  input SYSCLK,
  input [3:0] BTN,
  output [3:0] LED
);

  wire sys_clk;
  wire arst_n;
  wire rtl_gpio_out;
  wire hls_gpio_out;
  wire mb_gpio_out;
  wire ps_gpio_out;

  // external port connection
  assign sys_clk = SYSCLK;
  assign arst_n = ~BTN[0];
  assign LED[0] = rtl_gpio_out;
  assign LED[1] = hls_gpio_out;
  assign LED[2] = mb_gpio_out;
  assign LED[3] = ps_gpio_out;

  pl_system pl_system_inst(
    .sys_clk(sys_clk),
    .arst_n(arst_n),
    .rtl_gpio(rtl_gpio_out),
    .hls_gpio(hls_gpio_out),
    .mb_gpio_tri_o(mb_gpio_out),
    .ps_gpio_tri_o(ps_gpio_out)
  );

endmodule
