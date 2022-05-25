################################################################################
# Makefile for vitis embedded sdk project
#
# quick usage:
#   $ make build           # full compilation via local installed Xilinx tools
#   $ make ide             # open vitis GUI
#   $ make clean           # clean up generated files
################################################################################

.PHONY: default build ide clean

PROJ_ROOT=..
PROJ_NAME=mb_system
SCRIPT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
XSCT_PATH=$(shell readlink -f $(shell which xsct))
XBIN_ROOT=$(shell dirname $(XSCT_PATH))

default: build

# build under vitis introduced to PATH
build:
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct build.tcl

# open Vitis GUI
ide:
	@if !(type vitis > /dev/null 2>&1); then echo "command 'vitis' not found." ; exit 1 ; fi
	vitis --workspace=workspace

# cleanup generated files
clean:
	if [ -d ./workspace/$(PROJ_NAME)/src ]; then cp -rf workspace/$(PROJ_NAME)/src/* ./src/ ; fi
	rm -rf workspace .Xil
	rm -f *.log *.jou *.log *.str
