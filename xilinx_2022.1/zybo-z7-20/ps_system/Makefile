################################################################################
# Makefile for petalinux Project
#
# quick usage:
#   $ make config          # launch yocto linux build configurator
#   $ make oldconfig       # automated config via previous confs
#   $ make build           # full compilation via local installed Xilinx tools
#   $ make clean           # export IPs & clean up generated files
################################################################################

.PHONY: default all config oldconfig build clean

PROJ_ROOT := ..
DOWNLOAD_BIT_PATH := ${PROJ_ROOT}/mb_system/workspace/pl_system_wrapper_with_elf.bit
HW_DESCRIPTION_PATH := ${PROJ_ROOT}/pl_system/project

################################################################################
default: all

all:
	make oldconfig
	make build

config:
	@if !(type petalinux-config > /dev/null 2>&1); then echo "command 'petalinux-config' not found." ; exit 1 ; fi
	petalinux-config --get-hw-description=$(HW_DESCRIPTION_PATH)
	sed -i '/file:\/\/.* http:\/\/petalinux.xilinx.com\/sswreleases\/rel-v$${PETALINUX_MAJOR_VER}\/arm\/sstate-cache\/PATH;downloadfilename=PATH/d' build/conf/plnxtool.conf
	touch project-spec/hw-description/.gitkeep

oldconfig:
	@if !(type petalinux-config > /dev/null 2>&1); then echo "command 'petalinux-config' not found." ; exit 1 ; fi
	petalinux-config --silentconfig --get-hw-description=$(HW_DESCRIPTION_PATH)
	sed -i '/file:\/\/.* http:\/\/petalinux.xilinx.com\/sswreleases\/rel-v$${PETALINUX_MAJOR_VER}\/arm\/sstate-cache\/PATH;downloadfilename=PATH/d' build/conf/plnxtool.conf
	touch project-spec/hw-description/.gitkeep

build:
	@if !(type petalinux-config > /dev/null 2>&1); then echo "command 'petalinux-config' not found." ; exit 1 ; fi
	@if !(type petalinux-build > /dev/null 2>&1); then echo "command 'petalinux-build' not found." ; exit 1 ; fi
	@if !(type petalinux-package > /dev/null 2>&1); then echo "command 'petalinux-package' not found." ; exit 1 ; fi
	petalinux-build
	cp $(DOWNLOAD_BIT_PATH) ./images/linux/system.bit
	petalinux-package --force --boot --fsbl images/linux/zynq_fsbl.elf --fpga images/linux/system.bit --u-boot
	touch project-spec/hw-description/.gitkeep

clean:
	rm -f  project-spec/configs/config.old
	rm -f  project-spec/configs/rootfs_config.old
	find project-spec/hw-description/ ! -name '.gitkeep' -type f -exec rm -f {} \;
	rm -rf build
	rm -rf images
	rm -f  .petalinux/usage_statistics
	rm -f  .petalinux/usage_statistics_token
	rm -rf project-spec/meta-plnx-generated
	rm -rf components/plnx_workspace
	rm -rf components/yocto
	rm -rf .Xil
