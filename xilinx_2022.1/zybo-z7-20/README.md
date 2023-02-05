# template project for zybo Z7-20

## directory & files instruction

- hls\_repo : stores high-level synthesis ip submodule project
  + `$ make` here to compile and package ip via vitis\_hls

- pl\_system : Zynq-7000 PL design includes GPIO, DDR3 SDRAM MIG, and MicroBlaze instantiations
  + requires hls\_repo and other directories contains valid ip packages
  + `$ make` here to run vivado "restore project -> synthesis -> implementation -> generate bitstream -> export hardware" flow
  + once completed, you will get `pl_system/project/pl_system_wrapper.xsa` hw handoff module

- mb\_system : GPIO LED blinker program
  + requires vivado hw handoff file `pl_system/project/pl_system_wrapper.xsa`
  + `$ make` here to restore and build project via vitis, then you will get `mb_system/ctrl/pl_system_wrapper_with_elf.mcs` EEPROM configuration file

- ps\_system : PetaLinux build recipes
  + requires elf embedded PL bitstream `mb_system/workspace/pl_system_wrapper_with_elf.bit`
  + `$ make` here to run `$ make oldconfig` -> `$ make build` to get SDCard bootable files (BOOT.bin, boot.scr, and image.ub)

- qspi\_boot : bootloader for elf embedded PL bitstream
  + if you want to test elf embedded PL bitstream without SD Card boot YoctoLinux, try environment here to boot from QSPI

- Makefile : store useful make targets
  + `$ make` : `$ make build` -> `$ make output` run
    * `$ make build` : runs build flow on hls\_repo, pl\_system, and mb\_system directories respectively.
    * `$ make output` : collect output files on pl\_system and mb\_system
  + `$ make program` : one-time FPGA configuration via programming cable

## LED blinker test

- Type `$ make` here to execute CLI-based full compilation includes `{compile HLS module} -> {build circuit design with HLS module and RTL module} -> {compile microblaze code and embed on .bit} -> {initiate petalinux tool to bitbake minimal Yocto Linux image with .bit circuit design embedded}`.

- Type `$ make program` to write `output/pl_system_wrapper_with_elf.bit` to FPGA

- You can see 3 LEDs on board blinking while driven by RTL blinker module, HLS blinker module, and Microblaze blinker program respectively

- Type `$ make flash` to write `output/pl_system_wrapper_with_elf.mcs` to FPGA and you can see blinker test after zybo Z7-20 power cycle.

- Copy `BOOT.bin`, `boot.scr`, `image.ub` generated on `output` directory to some FAT32-formatted MicroSD card and attach on zybo Z7-20.

- Make sure boot selector jumper pin (JP5) is placed on `SD` and power on the board. you may see 3 of 4 leds blinks autonomously which means RTL / HLS / Microblaze modules are running.

- access PS console via serial port or ssh on ethernet ports (DHCP-enabled) and login with username: `petalinux`.
   + you will be requested to change your password on your first login.

- Issue `sudo bash -c "while true; do devmem 0x40000000 8 0xff; sleep 1; devmem 0x40000000 8 0x00; sleep 1; done"` to blink 4th led from PS.

## addr map

- Microblaze (/ctrl/mb/Data) 32bits M-AXI
  + `0x0000_0000` (128k) : microblaze data memory
  + `0x0004_0000` (128k) : microblaze interrupt controller
  + `0x0005_0000` (128k) : microblaze debug module
  + `0x0008_0000` (128k) : gpio led

- Microblaze (/ctrl/mb/Instruction) 32bits M-AXI
  + `0x0000_0000` (128k) : microblaze instruction memory

- ARM PS 32bits M-AXI
  + `0x4000_0000` (  4k) : gpio led
