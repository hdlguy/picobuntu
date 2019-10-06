# FPGA Design

This folder contains a simple FPGA design for the Picozed board on the Avnet FMC V2 carrier board.

## Build Instructions

    source /opt/Xilinx/Vivado/2019.1/settings64.sh
    cd implement
    vivado -mode batch -source setup.tcl
    vivado -mode batch -source compile.tcl

## Output files 

These files are written to the results folder. 

    top.bit - Native Xilinx configuration data used for downloading the design with the JTAG cable.
    top.bit.bin - Configuration data formatted for configuration at the Zed Linux command line.
    top.hdf - This is the hardware definition file used by the software tools Petalinux and SDK.
    top.ltx - This is the file that defines any In-system Logic Analyzer (ILA) cores in the design. It is needed for debugging.


