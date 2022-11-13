-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1.1_AR75502 (lin64) Build 2960000 Wed Aug  5 22:57:21 MDT 2020
-- Date        : Wed May 25 15:32:44 2022
-- Host        : hmmt32 running 64-bit Ubuntu 18.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /opt/work/dockerized/dockerized-xilinx-template/2020.1/ax7a200/pl_system/pl_system.srcs/sources_1/ip/sys_pll/sys_pll_stub.vhdl
-- Design      : sys_pll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sys_pll is
  Port ( 
    clk_out_400 : out STD_LOGIC;
    clk_out_200 : out STD_LOGIC;
    clk_out_100 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );

end sys_pll;

architecture stub of sys_pll is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out_400,clk_out_200,clk_out_100,resetn,locked,clk_in1_p,clk_in1_n";
begin
end;
