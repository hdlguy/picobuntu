# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
set_property board_part em.avnet.com:picozed_7020_fmc2:part0:1.2 [current_project]
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator
tclapp::install ultrafast -quiet

#file delete -force ./ip
#file mkdir ./ip

#read_ip ../source/fader2/prod_ila/prod_ila.xci

upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

# make the Zynq block diagram
source ../source/system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]
set_property synth_checkpoint_mode None    [get_files ./proj.srcs/sources_1/bd/system/system.bd]

#write_hwdef -force -verbose ./results/system.hdf

# Read in the hdl source.
read_verilog -sv  [glob ../source/top.sv]

read_xdc ../source/top.xdc
#read_xdc ../source/zed_system_constr.xdc

#read_xdc ../source/late.xdc
#set_property used_in_synthesis false [get_files ../source/late.xdc]

close_project

#########################



