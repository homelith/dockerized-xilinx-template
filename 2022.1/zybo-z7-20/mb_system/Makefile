################################################################################
# Makefile for vitis embedded sdk project
#
# quick usage:
#   $ make build           # full compilation via local installed Xilinx tools
#   $ make ide             # open vitis GUI
#   $ make clean           # clean up generated files
################################################################################

.PHONY: default xsct restore build update_hw ide clean

PROJ_ROOT=..
PROJ_NAME=mb_system
SCRIPT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
XSCT_PATH=$(shell readlink -f $(shell which xsct))
XBIN_ROOT=$(shell dirname $(XSCT_PATH))

default: build

# Launch xsct
xsct:
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct

# Restore the workspace.
restore: workspace

workspace:
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct restore.tcl

# build under vitis introduced to PATH
build: workspace
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct build.tcl

# Reload the platform definition.
update_hw: workspace
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct update_platform.tcl

# open Vitis GUI
ide: workspace
	@if !(type vitis > /dev/null 2>&1); then echo "command 'vitis' not found." ; exit 1 ; fi
	vitis --workspace=workspace

# cleanup generated files
clean:
	rm -rf workspace .Xil
	rm -f *.log *.jou *.log *.str
