################################################################################
# Makefile for Xilinx FPGA Project
#
# quick usage:
#   $ make build   # full compilation via PATH introduced Xilinx tools
#   $ make output  # collect output bitstreams into output/ directory
#   $ make clean   # cleanup generated files
################################################################################
.PHONY: build output clean

SCRIPT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PROJ_ROOT := .

all: build output

# `hls_repo -> pl_system -> microblaze SDK -> petalinux SDK` overall compilation using local installed Xilinx toolkit
build:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	@if !(type vitis_hls > /dev/null 2>&1); then echo "command 'vitis_hls' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	make -C hls_repo build
	make -C pl_system build
	make -C mb_system build

# copy output files into build dir
output:
	if ! [ -d output ]; then mkdir output; fi
	cp pl_system/project/pl_system.runs/impl_1/pl_system_wrapper.bit output/
	cp mb_system/workspace/pl_system_wrapper_with_elf.bit output/
	cp mb_system/workspace/pl_system_wrapper_with_elf.mcs output/
	cp mb_system/workspace/pl_system_wrapper_with_elf.prm output/

# cleanup cache / log / intermediate files except handoff files (.hdf / .bit / .mmi)
# to remove all handoffs, use `git clean -fdx` with care
clean:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	@if !(type vitis_hls > /dev/null 2>&1); then echo "command 'vitis_hls' not found. try 'make docker' to get tool suite." ; exit 1 ; fi
	rm -rf output
	make -C mb_system clean
	make -C pl_system clean
	make -C hls_repo clean
