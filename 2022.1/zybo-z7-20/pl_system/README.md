## pl\_system vivado project

### files

- README.md : this file
- Makefile : stores useful shortcut commands
- restore.tcl : script for restoring vivado project
  + src\_file.tcl : (generated via `make export`) script for adding source files into project
  + pl\_system.tcl : (vivado generated) script for reconstructing pl\_system board design called by restore.tcl
- implement.tcl : "generate bd -> synthesis -> implement -> export xsa" automation script
- srcs : stores RTL modules and constraint xdcs

### typical development workflow

- clone fresh project
- `make restore` to restore vivado project on `project` directory
- `make ide` to open vivado project
- any RTL modules and constraints (xdcs) should be stored in srcs directory since `project` directory will be cleared on export
- if you added any source / constraints file to srcs directory, `make export` to regenerate src\_file.tcl
- board design modification can be exported by typing `write_bd_tcl pl_system.tcl -force` on tcl command line
- `make build` to execute automated "generate bd -> synthesis -> implement -> export xsa" procedure (you can also execute them step-by-step on GUI and tcl console)
- `make clean` to remove generated project (make sure all your modification made persistent before clean up)
- git commit changes

