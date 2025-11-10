# Add your files directory to the search path
FILESEXTRAPATHS := "${THISDIR}/files:${FILESEXTRAPATHS}"

# Add the patch
SRC_URI += "file://0001-Add-cstdint-include-to-SpvBuilder.h.patch"
