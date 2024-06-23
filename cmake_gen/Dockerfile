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
RUN /usr/local/share/get_cmake.sh $CMAKE_VERSION $JOBS

WORKDIR /$REPO

RUN git clone $REPO_URL /$REPO_NAME_TIMESTAMP

