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

FROM exterex/base-dev

ENV LANG C.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt update \
    && sudo apt --assume-yes install --no-install-recommends \
    clang \
    clang-format \
    clang-tidy \
    clangd

#RUN sudo apt --assume-yes install --no-install-recommends \
#    zlib1g \
#    libbz2-dev \
#    curl

#WORKDIR /tmp/
#RUN git clone https://github.com/Kitware/CMake.git \
#    && cd CMake && git checkout release \
#    && sudo ./bootstrap --system-curl --system-bzip2 --system-zlib \
#    --no-system-jsoncpp --prefix=/usr/local --bindir=/usr/local/bin \
#    --datadir=/usr/local/share; \
#    make && sudo make install \
#    && sudo rm -rf /tmp/CMake

RUN sudo apt --assume-yes install --no-install-recommends \
    cmake \
    ninja-build

RUN sudo apt --assume-yes install --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev

RUN sudo update-alternatives --install /usr/local/bin/python python /usr/bin/python3 1 \
    && sudo update-alternatives --install /usr/local/bin/pip pip /usr/bin/pip3 1

RUN sudo rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND dialog

CMD [ "bash" ]
