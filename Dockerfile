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
    lldb \
    clang-format \
    clang-tidy

RUN sudo apt --assume-yes install --no-install-recommends \
    valgrind

RUN sudo apt --assume-yes install --no-install-recommends \
    cmake \
    cmake-data \
    cmake-doc \
    ninja-build \
    make

RUN sudo apt --assume-yes install --no-install-recommends \
    python3 \
    python3-pip

RUN cd /usr/bin \
    && sudo ln -s python3 python \
    && sudo ln -s pip3 pip

RUN sudo rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND dialog

CMD [ "bash" ]
