if { [llength $argv] < 2 } {
    error "Usage: vivado -mode batch program.tcl -tclargs <ProjectName> <TopModuleName>"
}

set project_name     [lindex $argv 0]
set top_module_name  [lindex $argv 1]

open_project pl_system/project/${project_name}.xpr
update_compile_order -fileset sources_1

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target

current_hw_device [get_hw_devices xc7z020_1]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7z020_1] 0]

set_property PROBES.FILE {} [get_hw_devices xc7z020_1]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7z020_1]
set_property PROGRAM.FILE "output/${top_module_name}_with_elf.bit" [get_hw_devices xc7z020_1]
program_hw_devices [get_hw_devices xc7z020_1]
