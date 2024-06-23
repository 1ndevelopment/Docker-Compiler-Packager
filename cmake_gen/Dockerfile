FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

ARG CMAKE_VERSION
ARG JOBS
ARG REPO_URL
ARG REPO_NAME_TIMESTAMP

ENV PATH="${PATH}:/usr/bin"

RUN apt update && apt install -y \
    --no-install-recommends \
    apt-utils \
    gcc \
    g++ \
    make \
    libssl-dev \
    jq \
    curl \
    ca-certificates \
    git \
    && apt upgrade -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /cmake

COPY get_cmake.sh /usr/local/share/get_cmake.sh
RUN chmod +x /usr/local/share/get_cmake.sh
RUN source /usr/local/share/get_cmake.sh
RUN command -v cmake &> /dev/null && { echo "Building & installing cmake.$CMAKE_VERSION from source..."; build_cmake $CMAKE_VERSION $JOBS; } || { echo "CMake is not installed!"; echo "Installing from APT..."; apt install -y cmake; };

WORKDIR /$REPO

RUN git clone $REPO_URL /$REPO_NAME_TIMESTAMP

