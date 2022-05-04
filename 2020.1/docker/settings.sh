#!/bin/bash
XILINX_VERSION=2020.1

source /opt/Xilinx/Vitis/${XILINX_VERSION}/settings64.sh
source /opt/Xilinx/PetaLinux/${XILINX_VERSION}/settings.sh
echo "---- xilinx-tools:${XILINX_VERSION} container shell ----"
echo "'$ /root/install.sh' to install tools on /opt"
