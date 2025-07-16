FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    XPRA_PORT=10000

RUN apt-get update \
    && apt-get install -y \
      build-essential \
      git \
      cmake \
      xpra \
      xvfb \
      dbus-x11 \
      libgl1-mesa-dev \
      libglu1-mesa-dev \
      libasound2-dev \
      libx11-dev \
      libxrandr-dev \
      libxi-dev \
      libxinerama-dev \
      libxcursor-dev \
      libwayland-dev \
      libxkbcommon-dev \
      gcc-12 \
      g++-12 \
      inotify-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
 
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100

WORKDIR /opt/

RUN git clone --branch 5.0 --depth 1 https://github.com/raysan5/raylib.git \
    && cd raylib \
    && mkdir build \
    && cd build \
    && cmake .. \
      -DBUILD_SHARED_LIBS=ON \
      -DPLATFORM="Desktop" \
      -DOPENGL_VERSION="3.3" \
    && make -j$(nproc) \
    && make install \
    && ldconfig

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

WORKDIR /app
