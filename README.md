# meta-hero

*This layer has been developed and test with yocto scarthgap*

poky (git branch scarthgap)
https://github.com/yoctoproject/poky

Openembedded (git branch )

meta-ros (git branch )

# Instructions
sudo apt install -y bmap-tools diffstat gawk chrpath lz4

bitbake-layers add-layer meta-openembedded/meta-oe
bitbake-layers add-layer meta-openembedded/meta-python
bitbake-layers add-layer meta-raspberrypi
bitbake-layers add-layer meta-ros/meta-ros-common
bitbake-layers add-layer meta-ros/meta-ros2
bitbake-layers add-layer meta-ros/meta-ros2-jazzy
bitbake-layers add-layer meta-ros/meta-hero

# Building the Image
bitbake swarm-robot-jazzy

# Building and installing the SDK
bitbake -c populate_sdk swarm-robot-jazzy && ./tmp/deploy/sdk/poky-glibc-x86_64-swarm-robot-jazzy-jazzy-cortexa53-raspberrypi0-2w-64-toolchain-5.0.11.sh -d /home/mstarks/yocto_sdks/pi-zero -y


