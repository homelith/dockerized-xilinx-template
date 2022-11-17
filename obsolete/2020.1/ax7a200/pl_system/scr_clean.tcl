# set params
set PROJ_NAME pl_system
set BD_NAME pl_system
set BD_FILE "./${PROJ_NAME}.srcs/sources_1/bd/${BD_NAME}/${BD_NAME}.bd"

# open project and bd file
open_project "./${PROJ_NAME}.xpr"
open_bd_design "./${BD_FILE}"

# reset runs
reset_run impl_1
reset_run synth_1

# reset bd output product
export_ip_user_files -of_objects [get_files ${BD_FILE}] -sync -no_script -force -quiet
reset_target all [get_files ${BD_FILE}]
if { [get_fileset ${BD_NAME}] != "" } { delete_ip_run [get_files -of_objects [get_fileset ${BD_NAME}] ${BD_FILE}] }
