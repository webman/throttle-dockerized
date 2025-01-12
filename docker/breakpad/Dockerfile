FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    git \
    libtool \
    pkg-config \
    zlib1g-dev \
    python3 \
    python3-pip \
    tzdata \
    curl \
    && apt-get clean

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/depot_tools
ENV PATH="/usr/local/depot_tools:${PATH}"

RUN git clone https://github.com/google/breakpad.git /opt/breakpad
WORKDIR /opt/breakpad

RUN git clone https://chromium.googlesource.com/linux-syscall-support src/third_party/lss/
RUN ./configure && make && make install

WORKDIR /app
RUN mkdir -p /app/bin && cp /usr/local/bin/minidump_stackwalk /app/bin/minidump_stackwalk

ENTRYPOINT ["minidump_stackwalk"]
