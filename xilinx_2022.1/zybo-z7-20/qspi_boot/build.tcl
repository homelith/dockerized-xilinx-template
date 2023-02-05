setws workspace
platform read workspace/pl_system_wrapper/platform.spr
platform config -updatehw ../pl_system/project/pl_system_wrapper.xsa

puts "building app ..."
app build -name qspi_boot

puts "generating BOOT.bin ..."
exec bootgen -image qspi_boot_system_run.bif -arch zynq -o workspace/BOOT.bin 
