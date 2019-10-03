# Petalinux Development Cheatsheet
This file contains instructions to get Petalinux running on the Ultrazed SOM installed on the Avnet IO Carrier card. Avnet does not publish a current BSP for this board so first we create a custom BSP, then build Petalinux for it.

The objective is to end up with a Raspberry Pi style boot where the root filesystem is stored, non-volatile, on a SD card ext4 partition.  This kind of system is full Ubuntu Desttop Linux. Linux commands are independent excutables, not busybox. The apt package manager can be used to install applications such as git, python3, octave, apache, etc.  Software can be be checked out, edited, compiled, debugged and re-commited from an ssh shell on the Zynq board.

## One Time BSP Creation
Avnet has not released an official BSP for this board but it is easy to create.

    petalinux-create --force --type project --template zynq --name bspproj

Now configure the bsp project.

    cd bspproj/
    petalinux-config --get-hw-description=../../../fpga/implement/results/

This will bring up a configuration menu.  Make the following changes. These changes will automatically be incorporated into the Petalinux build based on the BSP.

    * Under "Image Packaging Configuration" ->
        "Root filesystem type" ->
            Select "SD Card"

    * Under "Subsystem AUTO Hardware Settings" ->
        "Advanced bootable images storage Settings" ->
            "u-boot env partition settings" ->
                "image storage media" ->
                    Select "primary sd"

    * Save and exit the configuration menu. Wait for configuration to complete.

    cd ..
    petalinux-package --bsp -p bspproj/ --output picozed.bsp

## Petalinux Build Project

Create the petalinux project. (Note: the BSP file name changes with version.)

    petalinux-create --force --type project --template zynq --source ./picozed.bsp --name proj1

Configure the petalinux project with the settings we need to run Ubuntu from the SD card.

    cd proj1

    petalinux-config --silentconfig --get-hw-description=../../../fpga/implement/results/

All the settings are made in the BSP creation so I run this with the --siilentconfig option. Run without that option if you want the GUI.

### Build the bootloader

    petalinux-build -c bootloader -x distclean

Run another configu menu.

    petalinux-config --silentconfig -c kernel

### Build the linux kernel

    petalinux-build

It takes a while to run.

### Create the boot files that u-boot expects.

    petalinux-package --force --boot --fsbl images/linux/zynq_fsbl.elf --u-boot images/linux/u-boot.elf

BOOT.BIN contains the ATF, PMUFW, FSBL, U-Boot.
image.ub contains the device tree and Linux kernel.

### Copy the boot files to the SD card.

    cp images/linux/BOOT.BIN /media/pedro/BOOT/
    cp images/linux/image.ub /media/pedro/BOOT/

It is assumed that you already partitioned the SD card.
- sudo gparted  (make sure you have the correct drive selected!)
- First partition called BOOT, FAT32, 512MB
- Second partition called rootfs, ext4, use the rest of the card.

## Get the Root Filesystem

Download the root filesystem. It is 360MB.

    wget https://releases.linaro.org/debian/images/developer-armhf/latest/linaro-stretch-developer-20170706-43.tar.gz

Uncompress the root filesystem preserving file attributes and ownership.

    sudo tar --preserve-permissions -zxvf linaro-stretch-developer-20170706-43.tar.gz

Copy the root filesystem onto the SD card preserving file attributes and ownership.

    sudo cp --recursive --preserve binary/* /media/pedro/rootfs/; sync

Eject the SD card from your workstation and install it in the eval board.

## Boot the Board

Connect to the USB uart port on the eval board and start a terminal emulator. I use screen sometimes.

    sudo screen /dev/ttyUSB1 115200
or
    sudo putty

Power on the board and watch the boot sequence. U-boot will time out and start linux. You should end up at the command prompt as root.

    If you connect an ethernet cable to your network you should be able to update the OS with

    apt update
    apt upgrade

You can start installing things.

    apt install man
    apt install subversion

It is a good idea to create a user for yourself and give it sudoer privileges.

    adduser myuser
    usermod -aG sudo myuser

I find some of the permissions are wrong

    sudo chmod u+s /bin/*

The serial  terminal is limiting so I like to ssh into the board. First, find the ip address of the zcu104.

    ifconfig (or "ip address")

    Then go back to your workstation.

    ssh myuser@<ip address>

## Configure the FPGA Fabric

Configure the PL side of the Zynq with an FPGA design. This has changed with this newer Linux on Zynq+.

    The FPGA build scripts in this repo create a top.bit.bin file.  Linux requires the bin format for runtime PL configuration.

    Go to your terminal on the Zynq+ Linux command line.

    Do a "git clone" or "git pull" to get the latest .bin file from the FPGA side of the repo.

        git clone https://github.com/hdlguy/picobuntu.git

    Copy .../fpga/implement/results/top.bit.bin to /lib/firmware. You may have to create /lib/firmware and chmod to 777.

    Change to root with "sudo su".

    echo top.bit.bin > /sys/class/fpga_manager/fpga0/firmware

    This last command should make the "Done" LED go green indicating success.

- Good luck.

