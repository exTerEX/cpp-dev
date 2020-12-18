FROM gcc:latest

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update
RUN apt-get -y install --no-install-recommends \
    sudo \
    locales \
    cmake \
    ninja-build \
    gdb

RUN apt-get -y autoremove python2 \
    && rm -rf /etc/python && rm -rf /etc/python2.7

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Temporary solution while waiting for llvm-8 to be included in buster main
RUN sudo echo "# deb http://snapshot.debian.org/archive/debian/20201209T232235Z buster-backports main">>/etc/apt/sources.list; \
    sudo echo "deb http://deb.debian.org/debian buster-backports main">>/etc/apt/sources.list; \
    sudo apt-get update && sudo apt-get -y install --no-install-recommends clang-format-8 clangd-8; \
    update-alternatives --install /usr/local/bin/clang-format clang-format /usr/bin/clang-format-8 1; \
    update-alternatives --install /usr/local/bin/clangd clangd /usr/bin/clangd-8 1
# End

RUN wget https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh -O - | bash || true

RUN sudo rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python3 1 \
    && wget -O get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py --disable-pip-version-check --no-cache-dir \
    && rm -f get-pip.py

ENV PATH="$PATH:/home/${USERNAME}/.local/bin"

ENV DEBIAN_FRONTEND=dialog

ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1

CMD []