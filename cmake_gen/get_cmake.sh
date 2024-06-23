#!/usr/bin/env bash

cmake_version="$1"
jobs="$2"
arch="$(echo "$(uname -s)-$(uname -m)")"

## Build chosen CMake version from source .tar.gz
build_cmake() {

    ## Determine latest CMake version
    if [ -z "$cmake_version" ]; then
        cmake_version=$(curl -s 'https://cmake.org/files/LatestRelease/cmake-latest-files-v1.json' | jq -r '.version.string')
    fi
    ## Assign processing units to compiler jobs
    if [ -z "$jobs" ]; then
        jobs=$(nproc)
    fi

    curl -OL https://github.com/Kitware/CMake/releases/download/v$cmake_version/cmake-$cmake_version-$arch.tar.gz
    tar -xzf cmake-$cmake_version-$arch.tar.gz
    cd cmake-$cmake_version-$arch
    ./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release
    make -j$jobs && make install
}

## Install chosen CMake version from installer .sh
install_cmake() {
    if [ -z "$cmake_version" ]; then
        cmake_version=$(curl -s 'https://cmake.org/files/LatestRelease/cmake-latest-files-v1.json' | jq -r '.version.string')
    fi

    if [ -z "$jobs" ]; then
        jobs=$(nproc)
    fi

    curl -OL https://github.com/Kitware/CMake/releases/download/v$cmake_version/cmake-$cmake_version-$arch.sh
    chmod +x cmake-$cmake_version-$arch.sh
    ./cmake-$cmake_version-$arch.sh --skip-license
}

## Compare Installed CMake to Required version
compare() {

    # Function to compare version numbers
    version_compare() {
        if [[ $1 == $2 ]]; then
            return 0
        fi
        local IFS=.
        local i ver1=($1) ver2=($2)
        for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
            ver1[i]=0
        done
        for ((i=0; i<${#ver1[@]}; i++)); do
            if [[ -z ${ver2[i]} ]]; then
                ver2[i]=0
            fi
            if ((10#${ver1[i]} > 10#${ver2[i]})); then
                return 1
            fi
            if ((10#${ver1[i]} < 10#${ver2[i]})); then
                return 2
            fi
        done
        return 0
    }

    # Required CMake version
    required_version="$1"

    # Get installed CMake version
    installed_version=$(cmake --version | head -n1 | awk '{print $3}')

    # Compare versions
    version_compare "$installed_version" "$required_version"
    comparison=$?

    if [ $comparison -eq 0 ] || [ $comparison -eq 1 ]; then
        echo "CMake version $installed_version is installed and meets the requirement (>= $required_version)."
        exit 0
    else
        echo "CMake version $installed_version is installed but does not meet the requirement (>= $required_version)."
        exit 1
    fi
}

## Determine CMake version
command -v cmake &> /dev/null && { compare $cmake_version; echo "Building & installing cmake.$cmake_version from source..."; build_cmake $cmake_version $jobs; } || { echo "CMake is not installed!"; echo "Installing cmake.$cmake_version from installer..."; install_cmake $cmake_version; };
