################################################################################
# Makefile for vivado HLS project
#
# quick usage:
#   $ make build           # full compilation via local installed Xilinx tools
#   $ make ide             # open vivado HLS GUI with $(HLS_PROJ_NAME)
#   $ make clean           # clean up generated files
################################################################################
.PHONY : default build ide clean

PROJ_ROOT=../..
HLS_PROJ_NAME=blink
SCRIPT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# default entry
default: build

# build under vivado_hls introduced to PATH
#   csim -> HDL synthesis -> C-HDL co-sim -> Export IP
build:
	@if !(type vivado_hls > /dev/null 2>&1); then echo "command 'vivado_hls' not found." ; exit 1 ; fi
	sed -i '/csim_design/d' $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/script.tcl
	sed -i '/cosim_design/d' $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/script.tcl
	LD_PRELOAD=/usr/lib/x86_64-linux-gnu/faketime/libfaketime.so.1 FAKETIME=-10y NO_FAKE_STAT=1 vivado_hls $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/script.tcl

# open vivado HLS GUI
ide:
	@if !(type vivado_hls > /dev/null 2>&1); then echo "command 'vivado_hls' not found." ; exit 1 ; fi
	LD_PRELOAD=/usr/lib/x86_64-linux-gnu/faketime/libfaketime.so.1 FAKETIME=-10y NO_FAKE_STAT=1 vivado_hls -p $(HLS_PROJ_NAME)

# cleanup generated ips
clean:
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/syn
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/sim
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/csim
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/impl
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/.autopilot
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/.debug
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/$(HLS_PROJ_NAME).funcunit
	rm -rf $(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)/$(HLS_PROJ_NAME)_data.json
	rm -f $(HLS_PROJ_NAME)/.vivado_hls_log_all.xml
	find . -name "*.log" -exec rm {} \;
