#!/bin/bash

WORK_DIR=installer_temp
INTERNAL_USER=user
XILINX_TOOL_VERSION=2020.1
XILINX_ROOT_DIR=/opt/Xilinx
INSTALLER_DIR=/opt/install_files
INSTALLER_UNIFIED_CONFIG_PATH=/root/install_config.txt
INSTALLER_UNIFIED_DIR=Xilinx_Unified_2020.1_0602_1208
INSTALLER_UNIFIED_ARCHIVE=${INSTALLER_UNIFIED_DIR}.tar.gz
INSTALLER_PETALINUX=petalinux-v2020.1-final-installer.run
INSTALLER_UPDATE_01_DIR=Xilinx_Vivado_Vitis_Update_2020.1.1_0805_2247
INSTALLER_UPDATE_01_ARCHIVE=${INSTALLER_UPDATE_01_DIR}.tar.gz
INSTALLER_AR75502_DIR=AR75502_vivado_2020_1_preliminary_rev1
INSTALLER_AR75502_ARCHIVE=${INSTALLER_AR75502_DIR}.zip
#INSTALLER_SSTATE_AARCH64=sstate_aarch64_2020.1.tar.gz
#INSTALLER_SSTATE_ARM=sstate_arm_2020.1.tar.gz
#INSTALLER_SSTATE_MBFULL=sstate_mb-full_2020.1.tar.gz
#INSTALLER_SSTATE_MBLITE=sstate_mb-lite_2020.1.tar.gz
#INSTALLER_DOWNLOADS=downloads_2020.1.tar.gz

if [ ${EUID:-${UID}} = 0 ]; then
    echo "error: cannot run on root priviledge"
    exit 1
fi

# check if installer file exists
if [ ! -f ${INSTALLER_DIR}/${INSTALLER_UNIFIED_ARCHIVE} ]; then
    echo "error: ${INSTALLER_DIR}/${INSTALLER_UNIFIED_ARCHIVE} not exists"
    exit 1
fi
if [ ! -f ${INSTALLER_DIR}/${INSTALLER_UPDATE_01_ARCHIVE} ]; then
    echo "error: ${INSTALLER_DIR}/${INSTALLER_UPDATE_01_ARCHIVE} not exists"
    exit 1
fi
if [ ! -f ${INSTALLER_DIR}/${INSTALLER_AR75502_ARCHIVE} ]; then
    echo "error: ${INSTALLER_DIR}/${INSTALLER_AR75502_ARCHIVE} not exists"
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
sudo ${INSTALLER_UNIFIED_DIR}/xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --product Vitis --batch Install --config /root/install_config.txt

# patching to 2020.1.1
echo "extracting 2020.1.1 patch ..."
tar zxf ${INSTALLER_DIR}/${INSTALLER_UPDATE_01_ARCHIVE}
echo "patching to 2020.1.1 ..."
sudo ${INSTALLER_UPDATE_01_DIR}/xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --edition 'Vivado HL WebPACK' --location ${XILINX_ROOT_DIR}

# patch AR75502 update
echo "extracting AR75502 patch ..."
unzip ${INSTALLER_DIR}/${INSTALLER_AR75502_ARCHIVE} -d ${INSTALLER_AR75502_DIR}
echo "applying AR75502 patch ..."
sudo mkdir -p ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/patches
sudo cp ${INSTALLER_AR75502_DIR}/vivado/data/patches/AR75502.dat ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/patches/
sudo cp ${INSTALLER_AR75502_DIR}/vivado/lib/lnx64.o/librdi_coregen.so ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/lib/lnx64.o/librdi_coregen.so

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
expect \"Do you accept Webtalk Terms and Conditions?\"
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
wget https://github.com/Avnet/bdf/archive/master.zip -O avnet.zip
wget https://github.com/Digilent/vivado-boards/archive/master.zip -O digilent.zip
unzip "*.zip"
unzip -o "*.zip"
sudo mkdir -p ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/boards/board_files
sudo cp -r bdf-master/* ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/boards/board_files/
sudo cp -r bdf-master/* ${XILINX_ROOT_DIR}/Vitis/${XILINX_TOOL_VERSION}/data/boards/board_files/
sudo cp -r vivado-boards-master/new/* ${XILINX_ROOT_DIR}/Vivado/${XILINX_TOOL_VERSION}/data/boards/board_files/
sudo cp -r vivado-boards-master/new/* ${XILINX_ROOT_DIR}/Vitis/${XILINX_TOOL_VERSION}/data/boards/board_files/

# introduce PATH
source /root/settings.sh
