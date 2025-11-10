# meta-hero/recipes-kernel/lttng/babeltrace_1.5.11.bbappend
# Fix dead upstream Git URI (git.efficios.com → github.com)

# Replace the dead repo with the new location
SRC_URI = "git://github.com/efficios/babeltrace.git;branch=stable-1.5;protocol=https"

# Ensure BitBake refetches the new repo
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"
