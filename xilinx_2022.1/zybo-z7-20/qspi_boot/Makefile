################################################################################
# Makefile for vitis embedded sdk project
#
# quick usage:
#   $ make xsct    # get xsct console
#   $ make restore # restore project files accoding to current directory path
#   $ make build   # restore -> full compilation via local installed Xilinx tools
#   $ make flash   # write BOOT.bin into QSPI EEPROM
#   $ make ide     # open vitis GUI
#   $ make clean   # clean up generated files
################################################################################

.PHONY: default xsct restore build flash ide clean

SCRIPT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
XSCT_PATH=$(shell readlink -f $(shell which xsct))
XBIN_ROOT=$(shell dirname $(XSCT_PATH))

default: build

# launch xsct
xsct:
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct

# Restore the workspace.
restore: workspace

workspace:
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	sudo chmod go+w /dev/stdout
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct restore.tcl

# build under vitis introduced to PATH
build: workspace
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	sed -e 's/{{current_dir}}/$(subst /,\/,$(shell pwd))/g' qspi_boot_system.bif > qspi_boot_system_run.bif
	sudo chmod go+w /dev/stdout
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct build.tcl

# open Vitis GUI
ide: workspace
	@if !(type vitis > /dev/null 2>&1); then echo "command 'vitis' not found." ; exit 1 ; fi
	vitis --workspace=workspace

# build under vitis introduced to PATH
flash: workspace
	@if !(type xvfb-run > /dev/null 2>&1); then echo "command 'xvfb-run' not found." ; exit 1 ; fi
	@if !(type xsct > /dev/null 2>&1); then echo "command 'xsct' not found." ; exit 1 ; fi
	sudo chmod go+w /dev/stdout
	xvfb-run $(XBIN_ROOT)/loader -exec rdi_xsct flash.tcl

# cleanup generated files
clean:
	rm -rf workspace .Xil
	rm -f qspi_boot_system_run.bif
	rm -f *.log *.jou *.log *.str
