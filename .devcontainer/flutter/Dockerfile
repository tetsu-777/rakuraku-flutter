# Base image
FROM dart:3.3.0-sdk As build

# Workdir
WORKDIR /workspace/rakuraku_reserve_front

# flutterに必要なパッケージ
RUN apt-get update && apt install -y --fix-missing ninja-build cmake clang libgtk-3-dev wget gnupg unzip lib32stdc++6 lib32z1
    
# Android Studioのバージョンを指定(https://developer.android.com/studio/archive?hl=ja)
ARG studio_version=2023.1.1.28 
# Chromeインストール
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-chrome-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${studio_version}/android-studio-${studio_version}-linux.tar.gz && \
    tar -xvf android-studio-${studio_version}-linux.tar.gz -C /opt && \
    rm android-studio-${studio_version}-linux.tar.gz

# Android SDKのパスを設定
ENV ANDROID_HOME /root/Android/Sdk
RUN echo "export ANDROID_HOME=${ANDROID_HOME}" >> /root/.bashrc
# Chromeのパスを設定
ENV CHROME_EXECUTABLE /usr/bin/google-chrome
# Android StudioのPATHを通す
ENV PATH ${PATH}:/opt/android-studio/bin
# Android SDKのパスを設定
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools

# Install Flutter
ARG PATH=/root/.pub-cache/bin:$PATH
ARG FLUTTER_VERSION=3.19.0
RUN dart pub global activate melos --verbose && \
    dart pub global activate fvm --verbose && \
    fvm doctor --verbose && \
    fvm install $FLUTTER_VERSION --verbose && \
    fvm use --force $FLUTTER_VERSION --verbose && \
    fvm flutter config --enable-web --enable-linux-desktop --enable-macos-desktop --enable-windows-desktop --enable-android --enable-ios --enable-fuchsia && \
    # fvm flutter precache --verbose && \
    fvm flutter doctor --verbose

# Set paths
ENV FVM_ROOT=/root/.pub-cache
ENV PATH $FVM_ROOT/bin:$PATH
