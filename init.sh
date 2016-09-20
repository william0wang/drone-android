#! /bin/bash

ver_file=/data/last_build

var=`cat $ver_file`

if [ -z $var  ]; then
    var=0
fi

if [ $var -lt 1 ]; then

    cd /data/android-sdk-linux
    axel --output=android-sdk.zip https://dl.google.com/android/repository/tools_r25.2.2-linux.zip
    unzip android-sdk.zip
    rm -f android-sdk.zip

    chown -R root.root /data/android-sdk-linux

    echo y | android update sdk --all --no-ui --filter \
    "platform-tools,build-tools-24.0.2,android-24,android-23,extra-android-m2repository,extra-google-google_play_services,extra-google-m2repository"

    cd /data/workspace
    git clone https://github.com/william0wang/initapp.git
    chmod 755 initapp/gradlew
    cd initapp && ./gradlew assembleRelease
    rm -rf initapp

    echo 1 >$ver_file

fi
