################################################################################
# Makefile for Xilinx FPGA Project
#
# quick usage:
#   $ make build   # full compilation via PATH introduced Xilinx tools
#   $ make clean   # cleanup generated files
################################################################################
.PHONY: build output clean

SCRIPT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PROJ_ROOT := .

all: build output

# `hls_repo -> pl_system -> microblaze SDK -> petalinux SDK` overall compilation using local installed Xilinx toolkit
build:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	@if !(type vivado_hls > /dev/null 2>&1); then echo "command 'vivado_hls' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	make -C hls_repo build
	make -C pl_system build
	make -C mb_system build
	make -C ps_system all pl_system

# copy output files into build dir
output:
	if ! [ -d output ]; then mkdir output; fi
	cp pl_system/pl_system.runs/impl_1/pl_system_wrapper.bit output/
	cp mb_system/workspace/download.bit output/
	cp ps_system/images/linux/BOOT.BIN output/
	cp ps_system/images/linux/image.ub output/
	cp ps_system/images/linux/boot.scr output/

# cleanup cache / log / intermediate files except handoff files (.hdf / .bit / .mmi)
# to remove all handoffs, use `git clean -fdx` with care
clean:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	@if !(type vivado_hls > /dev/null 2>&1); then echo "command 'vivado_hls' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	rm -rf output
	make -C ps_system clean
	make -C mb_system clean
	make -C pl_system clean
	make -C hls_repo clean
