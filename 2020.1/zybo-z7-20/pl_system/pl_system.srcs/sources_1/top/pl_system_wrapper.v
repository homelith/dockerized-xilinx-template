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
  
  // generate synchronized reset
  reg [16:0] arst_n_sample_cnt_r;
  reg [1:0] arst_n_sample_r;
  reg srst_n_r;
  always @ (posedge sys_clk or negedge arst_n) begin
    if (! arst_n) begin
      arst_n_sample_cnt_r <= 17'd0;
    end else begin
      arst_n_sample_cnt_r <= arst_n_sample_cnt_r + 17'd1;
    end
  end
  always @ (posedge sys_clk or negedge arst_n) begin
    if (! arst_n) begin
      arst_n_sample_r <= 2'd0;
    end else if (|{arst_n_sample_cnt_r} == 1'b0) begin
      arst_n_sample_r <= {arst_n_sample_r, arst_n};
    end else begin
      arst_n_sample_r <= arst_n_sample_r;
    end
  end
  always @ (posedge sys_clk) begin
    if (arst_n_sample_r[1] == arst_n_sample_r[0]) begin
      srst_n_r <= arst_n_sample_r[1];
    end else begin
      srst_n_r <= srst_n_r;
    end
  end

  pl_system pl_system_i(
    .sys_clk(sys_clk),
    .srst_n(srst_n_r),
    .rtl_gpio(rtl_gpio_out),
    .hls_gpio_tri_o(hls_gpio_out),
    .mb_gpio_tri_o(mb_gpio_out),
    .ps_gpio_tri_o(ps_gpio_out)
  );

endmodule
