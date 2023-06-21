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
  input           DDR_CLK_P,
  input           DDR_CLK_N,
  // SPI configuration Flash ROM (S25FL128SAGBHI210)
  inout           S25FL_IO0,
  inout           S25FL_IO1,
  inout           S25FL_IO2,
  inout           S25FL_IO3,
  output          S25FL_CS_N,
  // LEDs
  output          LED_A1,      // active LOW
  output          LED_A2,      // active LOW
  output          LED_A3,      // active LOW
  output          LED_A4,      // active LOW
  output          LED_M2,      // HDD active indicator
  // DDR3 SDRAM
  output          DDR3_reset_n
);

  wire clk_400;
  wire clk_200;
  wire clk_100;
  wire sys_pll_locked;
  wire rtl_gpio_out;
  wire hls_gpio_out;
  wire mb_gpio_out;

  reg [26:0] LED_cnt_r;

  // external port connection
  assign LED_A1 = LED_cnt_r[26];
  assign LED_A2 = ~rtl_gpio_out;
  assign LED_A3 = ~hls_gpio_out;
  assign LED_A4 = ~mb_gpio_out;

  assign LED_M2 = 1'b1;
  assign DDR3_reset_n = 1'b0;

  // terminate differential clock input and generate ddr system clock
  sys_pll sys_pll_inst
  (
    // Clock out ports
    .clk_out_400(clk_400),
    .clk_out_200(clk_200),
    .clk_out_100(clk_100),
    // Status and control signals
    .resetn(1'b1),
    .locked(sys_pll_locked),
    // Clock in ports
    .clk_in1_p(DDR_CLK_P),
    .clk_in1_n(DDR_CLK_N)
  );

  pl_system pl_system_inst(
    .clk_400(clk_400),
    .clk_200(clk_200),
    .clk_100(clk_100),
    .arst_n(sys_pll_locked),
    .rtl_gpio(rtl_gpio_out),
    .hls_gpio(hls_gpio_out),
    .mb_gpio_tri_o(mb_gpio_out)
  );

  always @ (posedge clk_200 or negedge sys_pll_locked) begin
    if (! sys_pll_locked) begin
      LED_cnt_r <= 27'd0;
    end else begin
      LED_cnt_r <= LED_cnt_r + 27'd1;
    end
  end

endmodule
