FROM mcr.microsoft.com/devcontainers/cpp:1-bookworm

USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    autoconf \
    automake \
    liblzma-dev \
    libomp-dev \
    libtool \
    m4 \
    make \
    pkg-config \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
