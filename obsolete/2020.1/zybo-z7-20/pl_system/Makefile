################################################################################
# Makefile for vivado Project
#
# quick usage:
#   $ make build           # full compilation via local installed Xilinx tools
#   $ make ide             # open vivado GUI with $(VIVADO_PROJ_NAME)
#   $ make clean           # export IPs & clean up generated files
################################################################################

.PHONY: default build ide clean

PROJ_ROOT=..
VIVADO_PROJ_NAME=pl_system
SCRIPT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# default entry
default: build

# generate BD targets -> synthesis -> implement -> bitgen
build:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado -mode batch -source scr_build.tcl

# open vivado GUI
ide:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado $(VIVADO_PROJ_NAME).xpr

# cleanup generated files
clean:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado -mode batch -source scr_clean.tcl
	rm -f vivado*.log vivado*.jou vivado*.str
	rm -rf *.cache *.hw *.ip_user_files *.runs *.sim *.hbs *.tmp
	rm -rf .Xil
	rm -f *.sysdef *.xsa *.log
