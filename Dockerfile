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
    gdb \
    clang-format

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN wget https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh -O - | bash || true

RUN sudo rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog

CMD []