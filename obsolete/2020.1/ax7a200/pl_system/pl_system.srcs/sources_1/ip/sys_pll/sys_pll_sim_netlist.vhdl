-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1.1_AR75502 (lin64) Build 2960000 Wed Aug  5 22:57:21 MDT 2020
-- Date        : Wed May 25 15:32:44 2022
-- Host        : hmmt32 running 64-bit Ubuntu 18.04.6 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /opt/work/dockerized/dockerized-xilinx-template/2020.1/ax7a200/pl_system/pl_system.srcs/sources_1/ip/sys_pll/sys_pll_sim_netlist.vhdl
-- Design      : sys_pll
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sys_pll_sys_pll_clk_wiz is
  port (
    clk_out_400 : out STD_LOGIC;
    clk_out_200 : out STD_LOGIC;
    clk_out_100 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sys_pll_sys_pll_clk_wiz : entity is "sys_pll_clk_wiz";
end sys_pll_sys_pll_clk_wiz;

architecture STRUCTURE of sys_pll_sys_pll_clk_wiz is
  signal clk_in1_sys_pll : STD_LOGIC;
  signal clk_out_100_sys_pll : STD_LOGIC;
  signal clk_out_200_sys_pll : STD_LOGIC;
  signal clk_out_400_sys_pll : STD_LOGIC;
  signal clkfbout_buf_sys_pll : STD_LOGIC;
  signal clkfbout_sys_pll : STD_LOGIC;
  signal reset_high : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_ibufgds : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufgds : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufgds : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufgds : label is "AUTO";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout3_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of plle2_adv_inst : label is "PRIMITIVE";
begin
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_sys_pll,
      O => clkfbout_buf_sys_pll
    );
clkin1_ibufgds: unisim.vcomponents.IBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk_in1_p,
      IB => clk_in1_n,
      O => clk_in1_sys_pll
    );
clkout1_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_out_400_sys_pll,
      O => clk_out_400
    );
clkout2_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_out_200_sys_pll,
      O => clk_out_200
    );
clkout3_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_out_100_sys_pll,
      O => clk_out_100
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 6,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 5.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 3,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 6,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 12,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => clkfbout_buf_sys_pll,
      CLKFBOUT => clkfbout_sys_pll,
      CLKIN1 => clk_in1_sys_pll,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => clk_out_400_sys_pll,
      CLKOUT1 => clk_out_200_sys_pll,
      CLKOUT2 => clk_out_100_sys_pll,
      CLKOUT3 => NLW_plle2_adv_inst_CLKOUT3_UNCONNECTED,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => locked,
      PWRDWN => '0',
      RST => reset_high
    );
plle2_adv_inst_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => resetn,
      O => reset_high
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sys_pll is
  port (
    clk_out_400 : out STD_LOGIC;
    clk_out_200 : out STD_LOGIC;
    clk_out_100 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of sys_pll : entity is true;
end sys_pll;

architecture STRUCTURE of sys_pll is
begin
inst: entity work.sys_pll_sys_pll_clk_wiz
     port map (
      clk_in1_n => clk_in1_n,
      clk_in1_p => clk_in1_p,
      clk_out_100 => clk_out_100,
      clk_out_200 => clk_out_200,
      clk_out_400 => clk_out_400,
      locked => locked,
      resetn => resetn
    );
end STRUCTURE;
