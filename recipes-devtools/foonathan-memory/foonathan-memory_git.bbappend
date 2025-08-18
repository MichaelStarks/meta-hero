# meta-hero/recipes-devtools/foonathan-memory/foonathan-memory_git.bbappend

do_install:append() {
    install -d ${D}${libdir}
    install -m 0644 ${B}/src/libfoonathan_memory-*.a ${D}${libdir}/
}

# Make sure the static library is in the -dev package
FILES:${PN}-dev += "${libdir}/libfoonathan_memory-*.a"
