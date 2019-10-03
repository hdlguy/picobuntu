# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
set_property board_part em.avnet.com:picozed_7020_fmc2:part0:1.2 [current_project]
#set_property board_part em.avnet.com:microzed_7020:part0:1.2 [current_project]

set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator

#set_property  ip_repo_paths ../../hls/cholesky_inverse/csynth/solution1/impl/ip/ [current_project]
update_ip_catalog

#read_ip ../source/output_ila/output_ila.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

# Read in the hdl source.
read_verilog -sv ../source/top.sv

read_xdc ../source/top.xdc
#set_property used_in_synthesis false [get_files ../source/top.xdc]

# make the Zynq block diagram
source ../source/system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]
set_property synth_checkpoint_mode None    [get_files ./proj.srcs/sources_1/bd/system/system.bd]

close_project

#########################

