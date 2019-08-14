#!/bin/bash
echo Checking for existing image ..
if [ -z "`docker images -q xlights-build`" ];
then docker build -t xlights-build .
echo Built
fi
echo Done
echo Checking for existing VM
if [ -n "`docker ps -aq -f name=buildvm`" ];
then docker rm buildvm > /dev/null
echo Removed
fi
echo Done
echo Building appimage
docker run --name buildvm xlights-build /bin/bash Recipe.appimage
echo Copying appimage to local AppImage directory
docker cp buildvm:/xLights/xLights/AppImage/ .

