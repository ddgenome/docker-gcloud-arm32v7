#!/bin/bash
# simple docker build

set -o pipefail

declare Pkg=travis-build-docker-arm
declare Version=0.1.0

function msg () {
    echo "$Pkg: $*"
}

function err () {
    msg "$*" 1>&2
}

function main () {
    if ! docker run --rm --privileged multiarch/qemu-user-static:register --reset; then
        err "failed to register qemu"
        return 1
    fi
    if ! docker build -t "$TRAVIS_REPO_SLUG" .; then
        err "docker build failed"
        return 1
    fi
    if ! docker run --rm $TRAVIS_REPO_SLUG gcloud --version; then
        err "test failed"
        return 1
    fi
}

main "$@" || exit 1
exit 0
