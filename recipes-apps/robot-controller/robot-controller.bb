DESCRIPTION = "Robot controller init script for WiFi setup"
SUMMARY = "Installs wifi_up.sh into init.d and enables it at boot"
LICENSE = "CLOSED"

SRC_URI = "file://wifi_up.sh \
           file://netconfig.sh"

inherit update-rc.d

INITSCRIPT_NAME = "wifi_up.sh"
INITSCRIPT_PARAMS = "defaults 99"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/wifi_up.sh ${D}${sysconfdir}/init.d/wifi_up.sh

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/netconfig.sh ${D}${bindir}/netconfig
}

FILES:${PN} += "${sysconfdir}/init.d/wifi_up.sh"
