ARG ARCH=
FROM ${ARCH}ubuntu:noble

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --force-yes g++ gcc build-essential wget curl git fuse colormake cbp2make patchelf gpgv
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --force-yes libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev freeglut3-dev libavcodec-dev libavformat-dev libswscale-dev libsdl2-dev libavutil-dev libportmidi-dev libzstd-dev libcurl4-openssl-dev  libltc-dev librsvg2-dev liblua5.3-dev libwebp-dev  libsecret-1-dev
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get clean

# Build wxwidgets
ARG WXWIDGETS_TAG=xlights_2026.04
RUN cd / && \
    git clone --depth=1 --shallow-submodules  --recurse-submodules -b ${WXWIDGETS_TAG} https://github.com/xLightsSequencer/wxWidgets ${WXWIDGETS_TAG} && \
    cd ${WXWIDGETS_TAG} && \
    ./configure --with-cxx=17 --enable-std_containers --enable-std_string_conv_in_wxstring --enable-backtrace --enable-exceptions --enable-mediactrl --enable-graphics_ctx --enable-shared --disable-sdltest --with-gtk=3 --enable-glcanvasegl --disable-pcx --disable-iff --without-libtiff --enable-utf8 --enable-utf8only --prefix=/usr && \
    make -j 4 && \
    make install PREFIX=/usr && \
    cd .. && \
    rm -rf ${WXWIDGETS_TAG} && \
    echo "${WXWIDGETS_TAG}" > /etc/wxwidgets_tag

# Build log4cpp
RUN cd / && \
    wget -c https://downloads.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.4.tar.gz && \
    tar xfz log4cpp-1.1.4.tar.gz && \
    rm log4cpp-1.1.4.tar.gz && \
    cd log4cpp && \
    ./configure --prefix=/usr && \
    make -j 4 && \
    make install PREFIX=/usr && \
    cd .. && \
    rm -rf log4cpp

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
