DESCRIPTION = "Robot controller init script for WiFi setup"
SUMMARY = "Installs wifi_up.sh into init.d and enables it at boot"
LICENSE = "CLOSED"

SRC_URI = "file://wifi_up.sh \
           file://netconfig.sh \
           file://start_controller.sh"

inherit update-rc.d

INITSCRIPT_NAME = "wifi_up.sh"
INITSCRIPT_PARAMS = "defaults 99"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${bindir}
    
    install -m 0755 ${WORKDIR}/wifi_up.sh ${D}${sysconfdir}/init.d/wifi_up.sh

    # install -m 0755 ${WORKDIR}/start_controller.sh ${D}${sysconfdir}/init.d/start_controller.sh

    install -m 0755 ${WORKDIR}/netconfig.sh ${D}${bindir}/netconfig
}

FILES:${PN} += "${sysconfdir}/init.d/netconfig.sh"
FILES:${PN} += "${sysconfdir}/init.d/wifi_up.sh"
FILES:${PN} += "${sysconfdir}/init.d/start_controller.sh"
