#### Installing Software ####
FROM ubuntu:18.04 AS Base
ENV INTERNAL_USER=xuser
ENV FILE_DIR=docker

# install pkgs
RUN dpkg --add-architecture i386

# reserved for Xvfb + Desktop env running on Container
#   default-jre vnc4server twm binutils u-boot-tools file
#   tofrodos iproute2 tftp tftpd-hpa libssl-dev flex bison libselinux1 diffstat chrpath libtool socat
#   libsdl1.2-dev libglib2.0-dev libtool-bin


# useful pkg for development
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git vim screen tmux rsync usbutils wget x11-apps xorg xterm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# required pkg for running installer
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf build-essential expect gawk gcc-multilib libtool libncurses5-dev libncursesw5-dev libxrender-dev libxtst-dev locales net-tools python3 sudo texinfo unzip zlib1g-dev zlib1g:i386 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# required pkg for running vivado/vitis and its workaround
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cpio faketime libgmp-dev libgtk2.0-0 xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# reserved for patching Y2K22
#COPY y2k22_patch-1.2.zip /opt/
#RUN unzip -d /opt/Xilinx /opt/y2k22_patch-1.2.zip && \
#    cd /opt/Xilinx && \
#    LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2020.1/tps/lnx64/python-2.7.16/lib/ /opt/Xilinx/Vivado/2020.1/tps/lnx64/python-2.7.16/bin/python2.7 /opt/Xilinx/y2k22_patch/patch.py

#### Global Settings ####
# set locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# copy install scripts
RUN chmod go+rx /root
COPY ${FILE_DIR}/install.sh /root/install.sh
COPY ${FILE_DIR}/install_config.txt /root/install_config.txt
RUN chmod +x /root/install.sh
COPY ${FILE_DIR}/settings.sh /root/settings.sh

#### User Settings ####
# add vivado user
RUN useradd -ms /bin/bash ${INTERNAL_USER}
RUN echo "${INTERNAL_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ${INTERNAL_USER}
WORKDIR /home/${INTERNAL_USER}

# modify user .bashrc
RUN echo "source /root/settings.sh" >> /home/${INTERNAL_USER}/.bashrc

#### Finalize ####
USER root
COPY ${FILE_DIR}/entrypoint.sh /root/entrypoint.sh
ENTRYPOINT [ "sh", "/root/entrypoint.sh" ]
CMD ["/bin/sh"]
