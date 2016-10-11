#! /bin/bash

ver_file=/data/workspace/last_build

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

if [ $var -lt 2 ]; then

    cd /data/android-sdk-linux
    mkdir licenses
    cd licenses
    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "android-sdk-license"
    echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "android-sdk-preview-license"

    echo 2 >$ver_file

fi

if [ $var -lt 3 ]; then

    echo y | android update sdk --all --no-ui --filter "build-tools-24.0.3"

    echo 3 >$ver_file

fi
