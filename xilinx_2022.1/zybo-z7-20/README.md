# template project for zybo Z7-20

## LED blinker test

- Type `$ make` to execute CLI-based full compilation includes `{compile HLS module} -> {build circuit design with HLS module and RTL module} -> {compile microblaze code and embed on .bit} -> {initiate petalinux tool to bitbake minimal Yocto Linux image with .bit circuit design embedded}`.

- Copy `BOOT.bin`, `boot.scr`, `image.ub` generated on `output` directory to some FAT32-formatted MicroSD card and attach on zybo Z7-20.

- Make sure boot selector jumper pin (JP5) is placed on `SD` and power on the board. you may see 3 of 4 leds blinks autonomously which means RTL / HLS / Microblaze modules are running.

- access PS console via serial port or ssh on ethernet ports (DHCP-enabled) and login with username: `petalinux`.
   + you will be requested to change your password on your first login.

- Issue `sudo bash -c "while true; do devmem 0x40000000 8 0xff; sleep 1; devmem 0x40000000 8 0x00; sleep 1; done"` to blink 4th led from PS.

## make your own design

- go to `hls_repo/{module name}` and `$ make ide` to launch Vitis GUI, you can modify HLS module behaviour by editing codes

- go to `pl_system` and `$ make ide` to launch Vivado GUI, you can add RTL codes, HLS IPs, and some built-in IP cores.

- go to `mb_system` and `$ make ide` to launch Vitis Embedded GUI, you can edit microblaze codes.
