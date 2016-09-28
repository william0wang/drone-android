FROM greatfox/oraclejdk8:latest

MAINTAINER William Wang "william@10ln.com"

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 axel unzip && \
apt-get clean

# Install Android SDK
# RUN mkdir -p /data/android-sdk-linux
# RUN cd /data/android-sdk-linux && axel --output=android-sdk.zip https://dl.google.com/android/repository/tools_r25.2.2-linux.zip && \
# unzip android-sdk.zip && rm -f android-sdk.zip
# RUN chown -R root.root /data/android-sdk-linux

# Setup environment
ENV ANDROID_HOME /data/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
# RUN echo y | android update sdk --all --no-ui --filter \
# "platform-tools,build-tools-24.0.2,android-24,android-23,extra-android-m2repository,extra-google-google_play_services,extra-google-m2repository"

# RUN which adb
# RUN which android

# GO to workspace
# RUN mkdir -p /data/workspace
WORKDIR /data/workspace

RUN mkdir -p /opt
COPY init.sh /opt/init.sh
RUN chmod 755 /opt/init.sh
CMD /opt/init.sh
