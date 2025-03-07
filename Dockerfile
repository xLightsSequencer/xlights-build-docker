ARG ARCH=
FROM ${ARCH}ubuntu:jammy

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --force-yes g++ gcc build-essential wget curl git fuse colormake cbp2make patchelf gpgv
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --force-yes libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev freeglut3-dev libavcodec-dev libavformat-dev libswscale-dev libsdl2-dev libavutil-dev libportmidi-dev libzstd-dev libcurl4-openssl-dev  libltc-dev librsvg2-dev liblua5.3-dev libwebp-dev  libsecret-1-dev
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get clean

# Build wxwidgets
RUN cd / && \
    git clone --depth=1 --shallow-submodules  --recurse-submodules -b xlights_2025.04 https://github.com/xLightsSequencer/wxWidgets xlights_2025.04 && \
    cd xlights_2025.04 && \
    ./configure --with-cxx=17 --enable-std_containers --enable-std_string_conv_in_wxstring --enable-backtrace --enable-exceptions --enable-mediactrl --enable-graphics_ctx --enable-shared --disable-sdltest --with-gtk=3 --enable-glcanvasegl --disable-pcx --disable-iff --without-libtiff --prefix=/usr && \
    make -j 4 && \
    make install PREFIX=/usr && \
    cd .. && \
    rm -rf xlights_2025.04

# Build log4cpp
RUN cd / && \
    wget -c https://nchc.dl.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.4.tar.gz && \
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
