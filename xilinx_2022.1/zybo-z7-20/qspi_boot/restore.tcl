setws workspace
platform create -name pl_system_wrapper -hw ../pl_system/project/pl_system_wrapper.xsa -arch {32-bit}
domain create -name {domain_ps7_cortexa9_0} -display-name {domain_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
app create -name qspi_boot -platform pl_system_wrapper -domain domain_ps7_cortexa9_0 -proc ps7_cortexa9_0 -template "Hello World"
