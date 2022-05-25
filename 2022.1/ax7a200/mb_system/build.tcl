setws workspace
platform create -name pl_system_wrapper -hw ../pl_system/pl_system_wrapper.xsa -arch {32-bit}
domain create -name {domain_mb} -display-name {domain_mb} -os {standalone} -proc {mb_system_mb} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
app create -name mb_system -platform pl_system_wrapper -domain domain_mb -proc mb_system_mb -template "Empty Application"
importsources -name mb_system -path src
app build -name mb_system
exec updatemem -force \
    -meminfo workspace/pl_system_wrapper/hw/pl_system_wrapper.mmi \
    -bit workspace/pl_system_wrapper/hw/pl_system_wrapper.bit \
    -data workspace/mb_system/Debug/mb_system.elf \
    -proc pl_system_inst/mb_system/mb \
    -out workspace/download.bit
exit
setws ./workspace
