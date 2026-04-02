Docker files for building xLights, xFade, xCapture, xScanner, and xSchedule AppImages.

## Building the Docker image

    docker build -t xlights-build .

## Building AppImages

Each application has its own build script:

    ./build-xlights.sh
    ./build-xFade.sh
    ./build-xCapture.sh
    ./build-xScanner.sh
    ./build-xSchedule.sh

The build scripts will create the Docker image if it doesn't already exist, compile the application inside a container, and copy the resulting AppImage to a local `AppImage/` directory.

## Manual usage

To just compile without packaging an AppImage:

    docker run --name buildvm xlights-build /bin/bash Recipe
    docker run --name buildvm-xfade xlights-build /bin/bash Recipe.xFade
    docker run --name buildvm-xcapture xlights-build /bin/bash Recipe.xCapture
    docker run --name buildvm-xscanner xlights-build /bin/bash Recipe.xScanner
    docker run --name buildvm-xschedule xlights-build /bin/bash Recipe.xSchedule
