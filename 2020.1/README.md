# dockerized environment for xilinx-tools:2020-1

## quick start

- get `docker` command introduced and accesible from non-privilege user
- prepare xilinx installer archive on `/opt/install_files` (listed on docker/install.sh)
- `$ make docker` to get xilinx-suitable ubuntu console or `$ make docker-xrdp` and access virtual Linux desktop (localhost:13389) by using some RDP clients
- `$ /root/install.sh` to install tools on /opt/Xilinx
- now you can use `vivado` / `vivado_hls` / `vitis` / `petalinux-{}` commands
