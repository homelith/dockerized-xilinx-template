## ps\_system petalinux Yocto building project

### files

- README.md : this file
- Makefile : stores useful shortcut commands
- config.project
- .petalinux
- components
- project-spec

### sstate-cache settings

- PetaLinux template project is configured with sstate-cache enabled according to howto article below
  + https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842475/PetaLinux+Yocto+Tips#PetaLinuxYoctoTips-HowtoreducebuildtimeusingSSTATECACHE

- pre-applied config

```
$ petalinux-config ---> Yocto Settings ---> Add pre-mirror url ---> file:///opt/Xilinx/PetaLinux/2022.1/downloads
$ petalinux-config ---> Yocto Settings ---> Local sstate feeds settings ---> /opt/Xilinx/PetaLinux/2022.1/sstate-cache/arm
$ petalinux-config ---> Yocto Settings ---> [*] Enable BB NO NETWORK
```

### build dependency

- `../pl_system/project/pl_system_wrapper.xsa`
- `../mb_system/workspace/pl_system_wrapper_with_elf.bit`
  + PL bitstream embedded with mb\_system compiled elf
