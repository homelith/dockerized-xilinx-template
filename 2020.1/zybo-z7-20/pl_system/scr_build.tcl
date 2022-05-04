# set params
set JOBS_NUM 16
set PROJ_NAME pl_system
set BD_NAME pl_system
set BD_FILE "${PROJ_NAME}.srcs/sources_1/bd/${BD_NAME}/${BD_NAME}.bd"
set IPS_TO_BE_UPGRADED "pl_system_4RBLIR7"

# open project and bd file
open_project "./${PROJ_NAME}.xpr"
open_bd_design "./${BD_FILE}"
update_compile_order -fileset sources_1

# reset runs
reset_run impl_1
reset_run synth_1

# upgrade HLS IPs since minor revision will be changed in build process
upgrade_ip [ get_ips {pl_system_4RBLIR7} ] -log ip_upgrade.log
export_ip_user_files -of_objects [ get_ips {pl_system_4RBLIR7} ] -no_script -sync -force -quiet

# reset bd output product
export_ip_user_files -of_objects [get_files ${BD_FILE}] -sync -no_script -force -quiet
reset_target all [get_files ${BD_FILE}]
if { [get_fileset ${BD_NAME}] != "" } { delete_ip_run [get_files -of_objects [get_fileset ${BD_NAME}] ${BD_FILE}] }

# generate bd output
generate_target -force all [get_files ${BD_FILE}]
export_ip_user_files -of_objects [get_files ${BD_FILE}] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ${BD_FILE}]

# implement and bitgen
launch_runs impl_1 -to_step write_bitstream -jobs ${JOBS_NUM}
wait_on_run impl_1
write_sysdef -force -hwdef ${PROJ_NAME}.runs/impl_1/${PROJ_NAME}_wrapper.hwdef -bitfile ${PROJ_NAME}_wrapper.bit -meminfo ${PROJ_NAME}_wrapper.mmi -file ${PROJ_NAME}_wrapper.sysdef

# export hardware
write_hw_platform -fixed -include_bit -force -file ${PROJ_NAME}_wrapper.xsa

