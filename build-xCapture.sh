#!/bin/bash
echo Checking for existing image ..
if [ -z "`docker images -q xlights-build`" ];
then docker build -t xlights-build .
echo Built
fi
echo Done
echo Checking for existing VM
if [ -n "`docker ps -aq -f name=buildvm-xcapture`" ];
then docker rm buildvm-xcapture > /dev/null
echo Removed
fi
echo Done
echo Building xCapture appimage
docker run --name buildvm-xcapture xlights-build /bin/bash Recipe.xCapture.appimage
echo Copying appimage to local AppImage directory
docker cp buildvm-xcapture:/xCapture/xCapture/AppImage/ .
