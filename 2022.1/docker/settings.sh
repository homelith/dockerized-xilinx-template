#!/bin/bash
XILINX_VERSION=2022.1

source /opt/Xilinx/Vitis/${XILINX_VERSION}/settings64.sh
source /opt/Xilinx/PetaLinux/${XILINX_VERSION}/settings.sh
export LC_ALL="C"
echo "---- xilinx-tools:${XILINX_VERSION} container shell ----"
echo "'$ /root/install.sh' to install tools on /opt"
