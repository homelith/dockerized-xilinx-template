
################################################################
# This is a generated script based on design: pl_system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source pl_system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# blink

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a200tfbg484-2
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name pl_system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:hls:blink:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
blink\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: localmem
proc create_hier_cell_localmem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_localmem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type rst SYS_Rst
  create_bd_pin -dir I -type clk sys_clk

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins sys_clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mb_system
proc create_hier_cell_mb_system { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mb_system() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio


  # Create pins
  create_bd_pin -dir I -type rst arst_n
  create_bd_pin -dir I -type clk clk

  # Create instance: gpio, and set properties
  set gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
 ] $gpio

  # Create instance: intc, and set properties
  set intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $intc

  # Create instance: intx, and set properties
  set intx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 intx ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.STRATEGY {1} \
 ] $intx

  # Create instance: localmem
  create_hier_cell_localmem $hier_obj localmem

  # Create instance: mb, and set properties
  set mb [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 mb ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {0} \
   CONFIG.C_AREA_OPTIMIZED {1} \
   CONFIG.C_CACHE_BYTE_SIZE {4096} \
   CONFIG.C_DCACHE_ADDR_TAG {0} \
   CONFIG.C_DCACHE_BYTE_SIZE {4096} \
   CONFIG.C_DCACHE_HIGHADDR {0x000000003fffffff} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_ICACHE_HIGHADDR {0x000000003fffffff} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_MMU_DTLB_SIZE {2} \
   CONFIG.C_MMU_ITLB_SIZE {1} \
   CONFIG.C_MMU_ZONES {2} \
   CONFIG.C_USE_BARREL {1} \
   CONFIG.C_USE_HW_MUL {1} \
   CONFIG.C_USE_MSR_INSTR {1} \
   CONFIG.C_USE_PCMP_INSTR {1} \
   CONFIG.C_USE_REORDER_INSTR {0} \
   CONFIG.G_TEMPLATE_LIST {8} \
 ] $mb

  # Create instance: mdm, and set properties
  set mdm [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {1} \
 ] $mdm

  # Create instance: rstgen, and set properties
  set rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rstgen ]

  # Create interface connections
  connect_bd_intf_net -intf_net gpio_gpio [get_bd_intf_pins gpio] [get_bd_intf_pins gpio/GPIO]
  connect_bd_intf_net -intf_net intx_M00_AXI [get_bd_intf_pins intc/s_axi] [get_bd_intf_pins intx/M00_AXI]
  connect_bd_intf_net -intf_net intx_M01_AXI [get_bd_intf_pins intx/M01_AXI] [get_bd_intf_pins mdm/S_AXI]
  connect_bd_intf_net -intf_net intx_M02_AXI [get_bd_intf_pins gpio/S_AXI] [get_bd_intf_pins intx/M02_AXI]
  connect_bd_intf_net -intf_net intx_interrupt [get_bd_intf_pins intc/interrupt] [get_bd_intf_pins mb/INTERRUPT]
  connect_bd_intf_net -intf_net mb_DLMB [get_bd_intf_pins localmem/DLMB] [get_bd_intf_pins mb/DLMB]
  connect_bd_intf_net -intf_net mb_ILMB [get_bd_intf_pins localmem/ILMB] [get_bd_intf_pins mb/ILMB]
  connect_bd_intf_net -intf_net mb_M_AXI_DP [get_bd_intf_pins intx/S00_AXI] [get_bd_intf_pins mb/M_AXI_DP]
  connect_bd_intf_net -intf_net mdm_MBDEBUG_0 [get_bd_intf_pins mb/DEBUG] [get_bd_intf_pins mdm/MBDEBUG_0]

  # Create port connections
  connect_bd_net -net arst_n [get_bd_pins arst_n] [get_bd_pins rstgen/ext_reset_in]
  connect_bd_net -net clk [get_bd_pins clk] [get_bd_pins gpio/s_axi_aclk] [get_bd_pins intc/processor_clk] [get_bd_pins intc/s_axi_aclk] [get_bd_pins intx/ACLK] [get_bd_pins intx/M00_ACLK] [get_bd_pins intx/M01_ACLK] [get_bd_pins intx/M02_ACLK] [get_bd_pins intx/S00_ACLK] [get_bd_pins localmem/sys_clk] [get_bd_pins mb/Clk] [get_bd_pins mdm/S_AXI_ACLK] [get_bd_pins rstgen/slowest_sync_clk]
  connect_bd_net -net mdm_Debug_SYS_Rst [get_bd_pins mdm/Debug_SYS_Rst] [get_bd_pins rstgen/mb_debug_sys_rst]
  connect_bd_net -net rstgen_bus_struct_reset [get_bd_pins localmem/SYS_Rst] [get_bd_pins rstgen/bus_struct_reset]
  connect_bd_net -net rstgen_interconnect_aresetn [get_bd_pins intx/ARESETN] [get_bd_pins rstgen/interconnect_aresetn]
  connect_bd_net -net rstgen_mb_reset [get_bd_pins intc/processor_rst] [get_bd_pins mb/Reset] [get_bd_pins rstgen/mb_reset]
  connect_bd_net -net rstgen_peripheral_aresetn [get_bd_pins gpio/s_axi_aresetn] [get_bd_pins intc/s_axi_aresetn] [get_bd_pins intx/M00_ARESETN] [get_bd_pins intx/M01_ARESETN] [get_bd_pins intx/M02_ARESETN] [get_bd_pins intx/S00_ARESETN] [get_bd_pins mdm/S_AXI_ARESETN] [get_bd_pins rstgen/peripheral_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hls_system
proc create_hier_cell_hls_system { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hls_system() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type rst arst_n
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir O -from 0 -to 0 gpio

  # Create instance: blink, and set properties
  set blink [ create_bd_cell -type ip -vlnv xilinx.com:hls:blink:1.0 blink ]

  # Create instance: invert_reset, and set properties
  set invert_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 invert_reset ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $invert_reset

  # Create instance: slice_gpio, and set properties
  set slice_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_gpio ]

  # Create port connections
  connect_bd_net -net arst_n [get_bd_pins arst_n] [get_bd_pins invert_reset/Op1]
  connect_bd_net -net blink_gpio_out [get_bd_pins blink/gpio_out] [get_bd_pins slice_gpio/Din]
  connect_bd_net -net clk [get_bd_pins clk] [get_bd_pins blink/ap_clk]
  connect_bd_net -net invert_reset_Res [get_bd_pins blink/ap_rst] [get_bd_pins invert_reset/Res]
  connect_bd_net -net slice_gpio_Dout [get_bd_pins gpio] [get_bd_pins slice_gpio/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set mb_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 mb_gpio ]


  # Create ports
  set arst_n [ create_bd_port -dir I arst_n ]
  set clk_100 [ create_bd_port -dir I -type clk -freq_hz 100000000 clk_100 ]
  set clk_200 [ create_bd_port -dir I -type clk -freq_hz 200000000 clk_200 ]
  set clk_400 [ create_bd_port -dir I -type clk -freq_hz 400000000 clk_400 ]
  set hls_gpio [ create_bd_port -dir O -from 0 -to 0 hls_gpio ]
  set rtl_gpio [ create_bd_port -dir O rtl_gpio ]

  # Create instance: blink, and set properties
  set block_name blink
  set block_cell_name blink
  if { [catch {set blink [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $blink eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: hls_system
  create_hier_cell_hls_system [current_bd_instance .] hls_system

  # Create instance: mb_system
  create_hier_cell_mb_system [current_bd_instance .] mb_system

  # Create interface connections
  connect_bd_intf_net -intf_net mb_gpio [get_bd_intf_ports mb_gpio] [get_bd_intf_pins mb_system/gpio]

  # Create port connections
  connect_bd_net -net arst_n [get_bd_ports arst_n] [get_bd_pins blink/arst_n] [get_bd_pins hls_system/arst_n] [get_bd_pins mb_system/arst_n]
  connect_bd_net -net clk_100 [get_bd_ports clk_100] [get_bd_pins hls_system/clk]
  connect_bd_net -net clk_200 [get_bd_ports clk_200] [get_bd_pins blink/clk] [get_bd_pins mb_system/clk]
  connect_bd_net -net hls_system_Dout_0 [get_bd_ports hls_gpio] [get_bd_pins hls_system/gpio]
  connect_bd_net -net rtl_gpio [get_bd_ports rtl_gpio] [get_bd_pins blink/gpio_out]

  # Create address segments
  assign_bd_address -offset 0x00080000 -range 0x00001000 -target_address_space [get_bd_addr_spaces mb_system/mb/Data] [get_bd_addr_segs mb_system/gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mb_system/mb/Data] [get_bd_addr_segs mb_system/localmem/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00050000 -range 0x00001000 -target_address_space [get_bd_addr_spaces mb_system/mb/Data] [get_bd_addr_segs mb_system/mdm/S_AXI/Reg] -force
  assign_bd_address -offset 0x00040000 -range 0x00001000 -target_address_space [get_bd_addr_spaces mb_system/mb/Data] [get_bd_addr_segs mb_system/intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mb_system/mb/Instruction] [get_bd_addr_segs mb_system/localmem/ilmb_bram_if_cntlr/SLMB/Mem] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


