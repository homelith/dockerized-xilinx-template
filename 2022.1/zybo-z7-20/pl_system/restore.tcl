if { [llength $argv] < 8 } {
    error "Usage: vivado -mode tcl restore_project.tcl --tclargs <ProjectName> <BoardRepoPath> <BoardPart> <IPRepoPath> <SrcFileTcl> <SrcFilePath> <BDTcl> <BDName>"
}

set project_name     [lindex $argv 0]
set board_repo_path  [lindex $argv 1]
set board_part       [lindex $argv 2]
set ip_repo_path     [lindex $argv 3]
set src_file_tcl     [lindex $argv 4]
set src_file_path    [lindex $argv 5]
set bd_tcl           [lindex $argv 6]
set bd_name          [lindex $argv 7]

create_project project/$project_name .

# add board_files repositories and specify board_part
set_param board.repoPaths [concat [file normalize ${board_repo_path}] [get_param board.repoPaths]]
set_property BOARD_PART_REPO_PATHS [get_param board.repoPaths] [current_project]
set_property board_part ${board_part} [current_project]

# add ip repositories
set_property IP_REPO_PATHS [file normalize ${ip_repo_path}] [current_project]
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
