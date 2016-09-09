FROM greatfox/oraclejdk8:latest

MAINTAINER William Wang "william@10ln.com"

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 axel unzip

# Install Android SDK
RUN mkdir -p /opt/android-sdk-linux
RUN cd /opt/android-sdk-linux && axel --output=android-sdk.zip https://dl.google.com/android/repository/tools_r25.1.7-linux.zip && unzip android-sdk.zip && rm -f android-sdk.zip
RUN chown -R root.root /opt/android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
RUN echo y | android update sdk --all --no-ui --filter "platform-tools,tools,build-tools,android-24,android-23,extra-android-m2repository,extra-google-google_play_services,extra-google-m2repository"

RUN which adb
RUN which android

# Cleaning
RUN apt-get clean

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
