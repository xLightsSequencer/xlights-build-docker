#!/bin/bash
echo Checking for existing image ..
if [ -z "`docker images -q xlights-build`" ];
then docker build -t xlights-build .
echo Built
fi
echo Done
echo Checking for existing VM
if [ -n "`docker ps -aq -f name=buildvm-xscanner`" ];
then docker rm buildvm-xscanner > /dev/null
echo Removed
fi
echo Done
echo Building xScanner appimage
docker run --name buildvm-xscanner xlights-build /bin/bash Recipe.xScanner.appimage
echo Copying appimage to local AppImage directory
docker cp buildvm-xscanner:/xScanner/xScanner/AppImage/ .
