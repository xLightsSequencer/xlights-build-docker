#!/bin/bash
echo Checking for existing image ..
if [ -z "`docker images -q xlights-build`" ];
then docker build -t xlights-build .
echo Built
fi
echo Done
echo Checking for existing VM
if [ -n "`docker ps -aq -f name=buildvm-xfade`" ];
then docker rm buildvm-xfade > /dev/null
echo Removed
fi
echo Done
echo Building xFade appimage
docker run --name buildvm-xfade xlights-build /bin/bash Recipe.xFade.appimage
echo Copying appimage to local AppImage directory
docker cp buildvm-xfade:/xFade/xFade/AppImage/ .
