DESCRIPTION = "Robot controller init script for WiFi setup and ROS startup"
SUMMARY = "Brings up WiFi and starts robot controller"
LICENSE = "CLOSED"

SRC_URI = "file://install \
           file://wifi_up.sh \
           file://netconfig.sh \
           file://start_controller.sh \
           file://robot_controller.launch.py "

S = "${WORKDIR}/install"

inherit update-rc.d

INITSCRIPT_NAME = "start_controller.sh"
INITSCRIPT_PARAMS = "defaults 99"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${bindir}

    install -m 0755 ${WORKDIR}/start_controller.sh ${D}${sysconfdir}/init.d/start_controller.sh
    install -m 0755 ${WORKDIR}/wifi_up.sh ${D}${bindir}/wifi_up
    install -m 0755 ${WORKDIR}/netconfig.sh ${D}${bindir}/netconfig

    # Install ROS binaries
    install -d ${D}/home/root/install
    cp -r ${S}/* ${D}/home/root/install/
    cp ${WORKDIR}/robot_controller.launch.py ${D}/home/root/robot_controller.launch.py
}

FILES:${PN} += "${sysconfdir}/init.d/start_controller.sh \
                ${bindir}/wifi_up \
                ${bindir}/netconfig \
                /home/root/install \
                /home/root/robot_controller.launch.py"

INSANE_SKIP:${PN} += "file-rdeps"