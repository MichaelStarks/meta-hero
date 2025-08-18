require ${COREBASE}/meta/recipes-core/images/core-image-base.bb


SUMMARY = "A image for powering the swarm fleet"

ROS_DISTRO="jazzy"

inherit ros_distro_${ROS_DISTRO}
inherit ${ROS_DISTRO_TYPE}_image

IMAGE_INSTALL:append = " \
    ros-core \
    python3-numpy \
    foonathan-memory \
"
CORE_IMAGE_EXTRA_INSTALL += "packagegroup-core-ssh-openssh foonathan-memory-dev i2cdev i2c-tools git robot-controller"

RDEPENDS:${PN} += "git pkgconfig"

do_create_spdx[noexec] = "1"

FILES:${PN}-dev += "${libdir}/libfoonathan_memory-*.a"

TOOLCHAIN_TARGET_TASK += " \
    ros-core \
    libstatistics-collector \
    console-bridge \
    rcl-yaml-param-parser \
    statistics-msgs \
    rosidl-default-runtime \
    rcl-logging-interface \
    ament-cmake-python \
    ament-cmake-lint-cmake \
    rosgraph-msgs \
    fastrtps-cmake-module \
    cyclonedds \
    ament-cmake-version \
    rcl \
    ament-cmake-core \
    ament-cmake-copyright \
    rcl-interfaces \
    ament-acceleration \
    rosidl-runtime-c \
    rosidl-typesupport-fastrtps-c \
    geometry-msgs \
    ament-cmake-cppcheck \
    ament-cmake-test \
    fastcdr \
    ament-cmake-uncrustify \
    ament-cmake-export-include-directories \
    rcpputils \
    rosidl-core-runtime \
    rmw-fastrtps-shared-cpp \
    ament-cmake-target-dependencies \
    ament-cmake-export-definitions \
    service-msgs \
    ament-cmake \
    rmw-implementation \
    type-description-interfaces \
    rosidl-typesupport-fastrtps-cpp \
    rclcpp \
    ament-cmake-cpplint \
    unique-identifier-msgs \
    ament-cmake-export-interfaces \
    builtin-interfaces \
    tinyxml2-vendor \
    rosidl-core-generators \
    rosidl-typesupport-c \
    ament-cmake-pep257 \
    ament-cmake-export-targets \
    ament-cmake-export-libraries \
    rcl-action \
    ament-cmake-xmllint \
    ament-cmake-export-link-flags \
    rcl-lifecycle \
    rmw-dds-common \
    ament-cmake-export-dependencies \
    rmw \
    tracetools \
    lifecycle-msgs \
    rosidl-typesupport-cpp \
    composition-interfaces \
    builtin-interfaces \
    std-msgs \
    rosidl-typesupport-interface \
    action-msgs \
    rosidl-runtime-cpp \
    class-loader \
    rosidl-dynamic-typesupport \
    ament-index-cpp \
    rosidl-typesupport-introspection-c \
    ament-cmake-gen-version-h \
    sensor-msgs \
    rosidl-typesupport-introspection-cpp \
    rcutils \
    ament-cmake-libraries \
    iceoryx-binding-c \
    rosidl-cmake \
    python-cmake-module \
    rosidl-generator-py \
    ament-package \  
    python3-numpy \
    python3-catkin-pkg \
    ament-cmake \
    ament-cmake-include-directories \
    ament-lint-cmake \
    ament-xmllint \
    ament-cmake-xmllint \
    python3-lark-parser \
    foonathan-memory \
    foonathan-memory-vendor \
    tf2 \
    tf2-ros \
    tf2-bullet \
    tf2-eigen \
    tf2-eigen-kdl \
    tf2-geometry-msgs \
    tf2-kdl \
    tf2-msgs \
    tf2-py \
    tf2-ros \
    tf2-ros-py \
    tf2-sensor-msgs \
    tf2-tools \
    tlsf \
    tlsf-cpp \
    sensor-msgs-py \
    sqlite3-vendor \
    map-msgs \
    geometry2 \
    angles \
    composition \
    cv-bridge \
    ament-cppcheck \
    ament-uncrustify \
    ament-cpplint \
    ament-pep257 \
"

TOOLCHAIN_HOST_TASK += " \
    nativesdk-python3-core \
    nativesdk-python3-setuptools \
    nativesdk-python3-pip \
    nativesdk-python3-wheel \
    nativesdk-python3-modules \
    nativesdk-python3-catkin-pkg \
    nativesdk-python3-colcon-core \
    nativesdk-python3-colcon-ros \
    nativesdk-python3-empy \
    nativesdk-ament-package \
    nativesdk-python3-numpy \
"