#!/bin/bash
echo Checking for existing image ..
if [ -z "`docker images -q xlights-build`" ];
then docker build -t xlights-build .
echo Built
fi
echo Done
echo Checking for existing VM
if [ -n "`docker ps -aq -f name=buildvm-xschedule`" ];
then docker rm buildvm-xschedule > /dev/null
echo Removed
fi
echo Done
echo Building xSchedule appimage
docker run --name buildvm-xschedule xlights-build /bin/bash Recipe.xSchedule.appimage
echo Copying appimage to local AppImage directory
docker cp buildvm-xschedule:/xSchedule/xSchedule/AppImage/ .
