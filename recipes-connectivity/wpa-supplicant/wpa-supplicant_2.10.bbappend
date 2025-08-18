FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://wpa_supplicant-wpa3.config \
            file://wpa_supplicant.conf"

do_configure:prepend() {
    cp ${WORKDIR}/wpa_supplicant-wpa3.config ${S}/.config
}

do_install:append() {

    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/wpa_supplicant.conf ${D}${sysconfdir}/wpa_supplicant.conf
}

FILES:${PN} += "${sysconfdir}/wpa_supplicant.conf"
