################################################################################
# Makefile for Xilinx FPGA Project
#
# quick usage:
#   $ make build   # full compilation via PATH introduced Xilinx tools
#   $ make output  # collect output bitstreams into output/ directory
#   $ make program # one-time FPGA configuration from {project_with_elf}.bit
#   $ make clean   # cleanup generated files
################################################################################
.PHONY: build output program flash clean

SCRIPT_DIR         := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PL_PROJ_NAME       := pl_system
PL_TOP_MODULE_NAME := pl_system_wrapper

all: build output

# `hls_repo -> pl_system -> microblaze SDK -> petalinux SDK` overall compilation using local installed Xilinx toolkit
build:
	make -C hls_repo build
	make -C pl_system build
	make -C mb_system build
	make -C ps_system all

# copy output files into build dir
output:
	if ! [ -d output ]; then mkdir output; fi
	cp pl_system/project/$(PL_PROJ_NAME).runs/impl_1/$(PL_TOP_MODULE_NAME).bit output/
	cp mb_system/workspace/$(PL_TOP_MODULE_NAME)_with_elf.bit output/
	cp ps_system/images/linux/BOOT.BIN output/
	cp ps_system/images/linux/image.ub output/
	cp ps_system/images/linux/boot.scr output/

# one-time FPGA configuration
program: output/$(PL_TOP_MODULE_NAME)_with_elf.bit
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado -mode batch -source program.tcl -tclargs $(PL_PROJ_NAME) $(PL_TOP_MODULE_NAME)

# cleanup cache / log / intermediate files except handoff files (.hdf / .bit / .mmi)
# to remove all handoffs, use `git clean -fdx` with care
clean:
	rm -rf output
	make -C qspi_boot clean
	make -C ps_system clean
	make -C mb_system clean
	make -C pl_system clean
	make -C hls_repo clean
