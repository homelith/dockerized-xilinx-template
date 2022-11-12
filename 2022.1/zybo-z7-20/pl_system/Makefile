################################################################################
# Makefile for vivado Project
#
# quick usage:
#   $ make restore      # restore project from $(SRC_FILE_TCL) and $(BD_TCL)
#   $ make build        # full compilation via local installed Xilinx tools
#   $ make ide          # open vivado GUI with $(VIVADO_PROJ_NAME)
#   $ make export       # regenerate src_file.tcl according to source files in `srcs` directory
#   $ make clean        # export IPs & clean up generated files
################################################################################

.PHONY: default restore build ide export clean

SCRIPT_DIR       := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VIVADO_PROJ_NAME := pl_system
VIVADO_PROJ_PATH := project/$(VIVADO_PROJ_NAME).xpr
BOARD_REPO_PATH  := $(abspath .)
BOARD_PART       := digilentinc.com:zybo-z7-20:part0:1.1
IP_REPO_PATH     := $(abspath ../hls_repo)
SRC_FILE_TCL     := $(abspath src_file.tcl)
SRC_FILE_PATH    := $(abspath srcs)
BD_TCL           := $(abspath pl_system.tcl)
BD_NAME          := pl_system

# default entry
default: build

# restore Vivado project
restore: $(VIVADO_PROJ_PATH)

$(VIVADO_PROJ_PATH):
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado -mode batch -source restore.tcl -tclargs $(VIVADO_PROJ_NAME) $(BOARD_REPO_PATH) $(BOARD_PART) $(IP_REPO_PATH) $(SRC_FILE_TCL) $(SRC_FILE_PATH) $(BD_TCL) $(BD_NAME)

# build all
build: $(VIVADO_PROJ_PATH)
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado -mode batch -source implement.tcl -tclargs $(VIVADO_PROJ_NAME) $(BD_NAME)

# open vivado GUI
ide: $(VIVADO_PROJ_PATH)
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	vivado $(VIVADO_PROJ_PATH) &

# record all .v, .sv, .xdc in srcs folder into src_file.tcl
export: $(VIVADO_PROJ_PATH)
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	@if [ -f src_file.tcl.bak ]; then echo "backup file 'src_file.tcl.bak' already exists. stopped."; exit 1; fi
	mv src_file.tcl src_file.tcl.bak
	echo "set src_path [lindex \$${argv} 0]" > src_file.tcl
	find $(SRC_FILE_PATH) -name "*.v" -exec bash -c "echo \"add_files {} -fileset [get_filesets sources_1]\" >> src_file.tcl" \;
	find $(SRC_FILE_PATH) -name "*.sv" -exec bash -c "echo \"add_files {} -fileset [get_filesets sources_1]\" >> src_file.tcl" \;
	find $(SRC_FILE_PATH) -name "*.xdc" -exec bash -c "echo \"add_files {} -fileset [get_filesets constrs_1]\" >> src_file.tcl" \;
	sed -i -e 's/$(subst /,\/,$(SRC_FILE_PATH))/\$${src_path}/g' src_file.tcl

# cleanup generated files
clean:
	@if !(type vivado > /dev/null 2>&1); then echo "command 'vivado' not found." ; exit 1 ; fi
	rm -f vivado*.log vivado*.jou vivado*.str 
	rm -rf project
	rm -rf .Xil NA
	rm -f *.sysdef *.xsa *.log
