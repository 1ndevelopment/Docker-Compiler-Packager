ARG DOCKER_OS_IMAGE

FROM $DOCKER_OS_IMAGE

SHELL ["/bin/bash", "-c"]

ARG CMAKE_VERSION
ARG JOBS
ARG REPO_URL
ARG REPO_NAME_TIMESTAMP

RUN apt update && apt install -y \
    --no-install-recommends \
    apt-utils \
    ninja-build \
    git \
    file \
    gcc \
    g++ \
    make \
    libssl-dev \
    jq \
    curl \
    ca-certificates \
    && apt upgrade -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /cmake

ENV PATH="$PATH:/cmake/bin"
COPY get_cmake.sh /usr/local/share/get_cmake.sh

RUN chmod +x /usr/local/share/get_cmake.sh
RUN /usr/local/share/get_cmake.sh $CMAKE_VERSION $JOBS

WORKDIR /$REPO

RUN git clone $REPO_URL /$REPO_NAME_TIMESTAMP

