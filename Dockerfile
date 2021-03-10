# Copyright 2021 Andreas Sagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:latest AS build

RUN apt update \
    && apt --assume-yes install --no-install-recommends \
    clang \
    make \
    unzip \
    python3 \
    tzdata

RUN apt --assume-yes install --no-install-recommends \
    libcurl4-openssl-dev \
    libexpat1-dev \
    libjsoncpp-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libnghttp2-dev \
    libzstd-dev \
    librhash-dev \
    libuv1-dev \
    libarchive-dev

ADD https://github.com/Kitware/CMake/archive/release.zip /tmp/cmake.zip
RUN unzip -q /tmp/cmake.zip -d /tmp \
    && cd /tmp/CMake-release \
    && ./bootstrap --system-libs --no-qt-gui --prefix=/usr/local \
    && make \
    && make install

ADD https://github.com/ninja-build/ninja/archive/release.zip /tmp/ninja.zip
RUN unzip -q /tmp/ninja.zip -d /tmp \
    && cd /tmp/ninja-release \
    && python3 configure.py --bootstrap \
    && mv /tmp/ninja-release/ninja /usr/local/bin

FROM exterex/base-dev

ENV LANG C.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt update \
    && sudo apt --assume-yes install --no-install-recommends \
    clang \
    clang-format \
    clang-tidy \
    clangd \
    lldb

RUN sudo apt --assume-yes install --no-install-recommends \
    libcurl4 \
    libjsoncpp1 \
    librhash0 \
    libuv1 \
    libarchive13 \
    zlib1g \
    libexpat1

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/share/cmake-* /usr/local/share/cmake

RUN VERSION=`cmake --version | grep -o -P '\s\d\.\d\d' | sed 's/^ *//g'` \
    && sudo mv /usr/local/share/cmake /usr/local/share/cmake-${VERSION}

RUN sudo apt --assume-yes install --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev

RUN sudo update-alternatives --install /usr/local/bin/python python /usr/bin/python3 1 \
    && sudo update-alternatives --install /usr/local/bin/pip pip /usr/bin/pip3 1

RUN sudo rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND dialog

CMD [ "bash" ]
