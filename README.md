# dockerized-xilinx-template

- Template xilinx project (aims) supporting multiple tool version and devboard

- Docker recipes for installing and running xilinx tools included, helps them run on various un-supported linux distros

## usage for docker

- Get docker command introduced and accessible from non-privilege user.

- Select Xilinx toolchain version on your purpose and `cd {TOOL_VERSION}`.
  + 2022.1 : available
  + obsolete/2020.1 : currently provided without Y2K22 patch, you have to trick vitis if it is before Dec 31, 2021 by using faketime libraries.

- Prepare `/opt/install_files` directory and place Xilinx Unified Installer, PetaLinux Installer, and some patches binary downloaded from Xilinx website.
  + file lists are shown on `docker/install.sh`

- `$ make docker` to build `xilinx-tools:{TOOL_VERSION}` image and and get console on the container with project directory and /opt directory are mounted transparently.
  + for headless environment and Docker on Mac users, use `$ make docker-xrdp` instead and access localhost:13389 Virtual Linux Desktop inside the container using some RDP client.

- Execute `$ /root/install.sh` to download and install xilinx tools on /opt/Xilinx/{TOOL\_VERSION}.

- Now you can use `vivado`, `vitis` and `petalinux-{}` command and develop codes on your will. drill into some template projects for your board and test compiling.

## usage for template project

- note : see indivisual template project (e.g. 2020.1/zybo-z7-20) README.md for check condition of project, explanations below are summary for common functionalities.

- Template projects are designed to provide RTL-based module / Vitis HLS based module / Microblaze / (YoctoLinux system if the device has PS) all included on project and let them compiled under CLI environment with just one `$ make` command.

- Since its xdc includes various periphearal port definition with commented-out, you can un-comment them to recover the function easily.

## USB programmer redirection on container

- Prepare udev rules for xilinx or digilent programmers can accessible from non-privileged users.

- `$ make docker` command args helps USB-JTAG programmer device accessible from inside the container, open Vivado Hardware Manager and check if the programming cable is recognized.

## for Ubuntu 20.04 on Windows 10 WSL2

- Get Vivado GUI via VcXsrv

  + install VcXsrv and start with "disable access control" option
  + add `export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0` to your .bashrc

- usb redirection via usbipd

  + currently usbip support is enabled by default kernel on WSL2 of Windows 10 21H2

```
sudo apt install linux-tools-5.4.0-77-generic hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/5.4.0-77-generic/usbip 20
```

## Licenses

- Copyrights of some wizard-generated files are held by Xilinx, Inc.,see header of indivisual files.
- Newly written codes are licensed under MIT license.


