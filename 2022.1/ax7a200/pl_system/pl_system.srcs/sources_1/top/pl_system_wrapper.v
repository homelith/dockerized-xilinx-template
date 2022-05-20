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
  input           SYS_CLK_P,
  input           SYS_CLK_N,
  // DDR3 SDRAM
  output  [14:0]  DDR3_addr,
  output  [2:0]   DDR3_ba,
  output          DDR3_cas_n,
  //output          DDR3_ck_n,
  //output          DDR3_ck_p,
  output          DDR3_cke,
  output          DDR3_cs_n,
  output  [3:0]   DDR3_dm,
  inout   [31:0]  DDR3_dq,
  //inout   [3:0]   DDR3_dqs_n,
  //inout   [3:0]   DDR3_dqs_p,
  output          DDR3_odt,
  output          DDR3_ras_n,
  output          DDR3_reset_n,
  output          DDR3_we_n,
  // push switches (active LOW)
  input           RESET,
  input           KEY1,
  input           KEY2,
  input           KEY3,
  input           KEY4,
  // LEDs
  output          SOM_LED1,  // active HIGH
  output          LED1,      // active LOW
  output          LED2,      // active LOW
  output          LED3,      // active LOW
  output          LED4       // active LOW
);

  wire clk_400;
  wire clk_200;
  wire clk_100;
  wire arst_n;
  wire sys_pll_locked;
  wire rtl_gpio_out;
  wire hls_gpio_out;
  wire mb_gpio_out;

  reg [26:0] SOM_LED1_cnt_r;

  // external port connection
  assign arst_n = RESET;
  assign SOM_LED1 = SOM_LED1_cnt_r[26];
  assign LED1 = RESET;
  assign LED2 = ~rtl_gpio_out;
  assign LED3 = ~hls_gpio_out;
  assign LED4 = ~mb_gpio_out;

  assign DDR3_addr = 15'd0;
  assign DDR3_ba = 3'd0;
  assign DDR3_cas_n = 1'b0;
  assign DDR3_cke = 1'b0;
  assign DDR3_cs_n = 1'b0;
  assign DDR3_dm = 4'd0;
  assign DDR3_dq = 32'hz;
  assign DDR3_odt = 1'b0;
  assign DDR3_ras_n = 1'b0;
  assign DDR3_reset_n = 1'b0;
  assign DDR3_we_n = 1'b0;

  // terminate differential clock input and generate ddr system clock
  sys_pll sys_pll_inst
  (
    // Clock out ports
    .clk_out_400(clk_400),
    .clk_out_200(clk_200),
    .clk_out_100(clk_100),
    // Status and control signals
    .resetn(arst_n),
    .locked(sys_pll_locked),
    // Clock in ports
    .clk_in1_p(SYS_CLK_P),
    .clk_in1_n(SYS_CLK_N)
  );

  pl_system pl_system_i(
    .clk_400(clk_400),
    .clk_200(clk_200),
    .clk_100(clk_100),
    .arst_n(sys_pll_locked),
    .rtl_gpio(rtl_gpio_out),
    .hls_gpio_tri_o(hls_gpio_out),
    .mb_gpio_tri_o(mb_gpio_out)
  );

  always @ (posedge clk_200 or negedge sys_pll_locked) begin
    if (! sys_pll_locked) begin
      SOM_LED1_cnt_r <= 27'd0;
    end else begin
      SOM_LED1_cnt_r <= SOM_LED1_cnt_r + 27'd1;
    end
  end

endmodule
