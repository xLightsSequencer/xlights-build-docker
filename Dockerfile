ARG ARCH=
FROM ${ARCH}ubuntu:noble

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y g++ gcc build-essential wget curl git fuse colormake cbp2make patchelf gpgv ccache
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev freeglut3-dev libavcodec-dev libavformat-dev libswscale-dev libsdl2-dev libavutil-dev libavfilter-dev libportmidi-dev libzstd-dev libcurl4-openssl-dev libltc-dev librsvg2-dev liblua5.3-dev libwebp-dev libsecret-1-dev libegl-dev libfreetype-dev libharfbuzz-dev libfontconfig-dev
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get clean

# Install ISPC
ARG ISPC_VERSION=1.30.0
RUN ISPC_ARCH=$(uname -m) && \
    if [ "$ISPC_ARCH" = "aarch64" ]; then \
        ISPC_URL="https://github.com/ispc/ispc/releases/download/v${ISPC_VERSION}/ispc-v${ISPC_VERSION}-linux.aarch64.tar.gz"; \
    else \
        ISPC_URL="https://github.com/ispc/ispc/releases/download/v${ISPC_VERSION}/ispc-v${ISPC_VERSION}-linux.tar.gz"; \
    fi && \
    curl -L -o /tmp/ispc.tar.gz "$ISPC_URL" && \
    tar -xzf /tmp/ispc.tar.gz -C /tmp && \
    cp /tmp/ispc-v${ISPC_VERSION}-linux*/bin/ispc /usr/local/bin/ispc && \
    rm -rf /tmp/ispc* && \
    echo "${ISPC_VERSION}" > /etc/ispc_version

ARG WXWIDGETS_TAG=xlights_2026.11
RUN cd / && \
    git clone --depth=1 --shallow-submodules  --recurse-submodules -b ${WXWIDGETS_TAG} https://github.com/xLightsSequencer/wxWidgets ${WXWIDGETS_TAG} && \
    cd ${WXWIDGETS_TAG} && \
    ./configure --with-cxx=17 --enable-std_containers --enable-std_string_conv_in_wxstring --enable-backtrace --enable-exceptions --enable-mediactrl --enable-graphics_ctx --enable-shared --disable-sdltest --with-gtk=3 --enable-glcanvasegl --disable-pcx --disable-iff --without-libtiff --enable-utf8 --enable-utf8only --prefix=/usr && \
    make -j 4 && \
    make install PREFIX=/usr && \
    cd .. && \
    rm -rf ${WXWIDGETS_TAG} && \
    echo "${WXWIDGETS_TAG}" > /etc/wxwidgets_tag

ADD Recipe.appimage /Recipe.appimage
ADD Recipe /Recipe
ADD Recipe.xFade /Recipe.xFade
ADD Recipe.xFade.appimage /Recipe.xFade.appimage
ADD Recipe.xCapture /Recipe.xCapture
ADD Recipe.xCapture.appimage /Recipe.xCapture.appimage
ADD Recipe.xScanner /Recipe.xScanner
ADD Recipe.xScanner.appimage /Recipe.xScanner.appimage
ADD Recipe.xSchedule /Recipe.xSchedule
ADD Recipe.xSchedule.appimage /Recipe.xSchedule.appimage
