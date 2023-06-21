# template project for lf-compat

## directory & files instruction

- hls\_repo : stores high-level synthesis ip submodule project
  + `$ make` here to compile and package ip via vitis\_hls

- pl\_system : Artix-7 FPGA design includes GPIO, DDR3 SDRAM MIG, and MicroBlaze instantiations
  + requires hls\_repo and other directories contains valid ip packages
  + `$ make` here to run vivado "restore project -> synthesis -> implementation -> generate bitstream -> export hardware" flow
  + once completed, you will get `pl_system/project/pl_system_wrapper.xsa` hw handoff module

- mb\_system : GPIO LED blinker program
  + requires vivado hw handoff file `pl_system/project/pl_system_wrapper.xsa`
  + `$ make` here to restore and build project via vitis, then you will get `mb_system/ctrl/pl_system_wrapper_with_elf.mcs` EEPROM configuration file

- Makefile : store useful make targets
  + `$ make` : `$ make build` -> `$ make output` run
    * `$ make build` : runs build flow on hls\_repo, pl\_system, and mb\_system directories respectively.
    * `$ make output` : collect output files on pl\_system and mb\_system
  + `$ make program` : one-time FPGA configuration via programming cable
  + `$ make flash` : write config into EEPROM on lf-compat board

## LED blinker test

- Type `$ make` here to execute CLI-based full compilation includes `{compile HLS module} -> {build circuit design with HLS module and RTL module} -> {compile microblaze code and embed on .bit}`.

- Type `$ make program` to write `output/pl_system_wrapper_with_elf.bit` to FPGA

- You can see 3 LEDs on board blinking while driven by RTL blinker module, HLS blinker module, and Microblaze blinker program respectively

- Type `$ make flash` to write `output/pl_system_wrapper_with_elf.mcs` to FPGA and you can see blinker test after board power cycle

## addr map

- Microblaze (/ctrl/mb/Data) 32bits M-AXI
  + `0x0000_0000` (128k) : microblaze data memory
  + `0x0004_0000` (128k) : microblaze interrupt controller
  + `0x0005_0000` (128k) : microblaze debug module
  + `0x0008_0000` (128k) : gpio led

- Microblaze (/ctrl/mb/Instruction) 32bits M-AXI
  + `0x0000_0000` (128k) : microblaze instruction memory
