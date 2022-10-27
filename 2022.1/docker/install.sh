#!/bin/bash

WORK_DIR=installer_temp
INTERNAL_USER=user
XILINX_TOOL_VERSION=2022.1
XILINX_ROOT_DIR=/opt/Xilinx
INSTALLER_DIR=/opt/install_files
INSTALLER_UNIFIED_CONFIG_PATH=/root/install_config.txt
INSTALLER_UNIFIED_DIR=Xilinx_Unified_2022.1_0420_0327
INSTALLER_UNIFIED_ARCHIVE=${INSTALLER_UNIFIED_DIR}.tar.gz
INSTALLER_PETALINUX=petalinux-v2022.1-04191534-installer.run

if [ ${EUID:-${UID}} = 0 ]; then
    echo "error: cannot run on root priviledge"
    exit 1
fi

# check if installer file exists
if [ ! -f ${INSTALLER_DIR}/${INSTALLER_UNIFIED_ARCHIVE} ]; then
    echo "error: ${INSTALLER_DIR}/${INSTALLER_UNIFIED_ARCHIVE} not exists"
    exit 1
fi
if [ ! -f ${INSTALLER_DIR}/${INSTALLER_PETALINUX} ]; then
    echo "error: ${INSTALLER_DIR}/${INSTALLER_PETALINUX} not exists"
    exit 1
fi

# prepare workdir
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}

# install unified installer
echo "extracting unified installer ..."
tar zxf ${INSTALLER_DIR}/${INSTALLER_UNIFIED_ARCHIVE}
echo "starting unified installer ..."
sudo ${INSTALLER_UNIFIED_DIR}/xsetup --agree XilinxEULA,3rdPartyEULA --product Vitis --batch Install --config /root/install_config.txt

# install petalinux
echo "preparing PetaLinux dir ..."
sudo mkdir -p ${XILINX_ROOT_DIR}/PetaLinux/${XILINX_TOOL_VERSION}
sudo chown ${INTERNAL_USER}:${INTERNAL_USER} ${XILINX_ROOT_DIR}/PetaLinux/${XILINX_TOOL_VERSION}
echo "starting PetaLinux installer ..."
expect -c "
set timeout 3600
spawn bash ${INSTALLER_DIR}/${INSTALLER_PETALINUX} -d ${XILINX_ROOT_DIR}/PetaLinux/${XILINX_TOOL_VERSION}
expect \"Press Enter to display the license agreements\"
sleep 1
send \"\n\"
sleep 3
send \"q\"
expect \"Do you accept Xilinx End User License Agreement?\"
sleep 1
send \"y\n\"
sleep 3
send \"q\"
expect \"Do you accept Third Party End User License Agreement?\"
sleep 1
send \"y\n\"
wait
puts \"\ninstallation completed.\"
exit 0
"

# install recommended bdf
# note : board_files directory is not created by default on Xilinx 2022.1
wget https://github.com/Avnet/bdf/archive/master.zip -O avnet.zip
wget https://github.com/Digilent/vivado-boards/archive/master.zip -O digilent.zip
unzip -o "*.zip"
sudo mkdir -p ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/boards/board_files
sudo cp -r bdf-master/* ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/boards/board_files/
sudo cp -r bdf-master/* ${XILINX_ROOT_DIR}/Vitis/${XILINX_TOOL_VERSION}/data/boards/board_files/
sudo cp -r vivado-boards-master/new/* ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/boards/board_files/
sudo cp -r vivado-boards-master/new/* ${XILINX_ROOT_DIR}/Vitis/${XILINX_TOOL_VERSION}/data/boards/board_files/

# introduce PATH
source /root/settings.sh


