if { [llength $argv] < 7 } {
    error "Usage: vivado -mode tcl restore_project.tcl --tclargs <ProjectName> <FPGAPart> \"<IPRepoPaths>\" <SrcFileTcl> <SrcFilePath> <BDTcl> <BDName>"
}

set project_name     [lindex $argv 0]
set fpga_part        [lindex $argv 1]
set ip_repo_paths    [lindex $argv 2]
set src_file_tcl     [lindex $argv 3]
set src_file_path    [lindex $argv 4]
set bd_tcl           [lindex $argv 5]
set bd_name          [lindex $argv 6]

create_project project/${project_name} .

# specify fpga part
set_property part ${fpga_part} [current_project]

# add ip and hls repositories
set ip_repo_path_list [split ${ip_repo_paths} " "]
set_property IP_REPO_PATHS [file normalize ${ip_repo_path_list}] [get_filesets sources_1]
update_ip_catalog

# add source files
set argv [list ${src_file_path}]
set argc 2
source ${src_file_tcl}

# restore board design
set argv ""
set argc 0
source ${bd_tcl}

# uncomment below to enable auto-generated bd wrapper
#make_wrapper -top -fileset sources_1 -import [get_files project/$project_name.srcs/sources_1/bd/${bd_name}/${bd_name}.bd]
