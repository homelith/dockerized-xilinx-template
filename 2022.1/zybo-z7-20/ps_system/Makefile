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

PROJ_ROOT=..
PATH_DOWNLOAD_BIT=../mb_system/workspace/pl_system_wrapper_with_elf.bit

# this Makefile read only first arguments as target and the rest as arguments for target
# arguments are treated as do-nothing targets from here
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)


################################################################################
default: all

all:
	@if [ -z $(firstword $(RUN_ARGS)) ] ; then echo "error : no positional argument specified (e.g. '$$ make {cmd} {positional arg}')"; exit 1 ; fi
	make oldconfig $(firstword $(RUN_ARGS))
	make build $(firstword $(RUN_ARGS))

config:
	@if [ -z $(firstword $(RUN_ARGS)) ] ; then echo "error : no positional argument specified (e.g. '$$ make {cmd} {positional arg}')"; exit 1 ; fi
	@if !(type petalinux-config > /dev/null 2>&1); then echo "command 'petalinux-config' not found." ; exit 1 ; fi
	petalinux-config --get-hw-description=$(PROJ_ROOT)/$(firstword $(RUN_ARGS))/project

oldconfig:
	@if [ -z $(firstword $(RUN_ARGS)) ] ; then echo "error : no positional argument specified (e.g. '$$ make {cmd} {positional arg}')"; exit 1 ; fi
	@if !(type petalinux-config > /dev/null 2>&1); then echo "command 'petalinux-config' not found." ; exit 1 ; fi
	petalinux-config --silentconfig --get-hw-description=$(PROJ_ROOT)/$(firstword $(RUN_ARGS))/project

build:
	@if [ -z $(firstword $(RUN_ARGS)) ] ; then echo "error : no positional argument specified (e.g. '$$ make {cmd} {positional arg}')"; exit 1 ; fi
	@if !(type petalinux-config > /dev/null 2>&1); then echo "command 'petalinux-config' not found." ; exit 1 ; fi
	@if !(type petalinux-build > /dev/null 2>&1); then echo "command 'petalinux-build' not found." ; exit 1 ; fi
	@if !(type petalinux-package > /dev/null 2>&1); then echo "command 'petalinux-package' not found." ; exit 1 ; fi
	petalinux-build
	cp $(PATH_DOWNLOAD_BIT) ./images/linux/system.bit
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
	touch project-spec/hw-description/.gitkeep
