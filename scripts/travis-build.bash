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

    local commit=$TRAVIS_COMMIT
    if [[ $TRAVIS_TAG =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        commit=$TRAVIS_TAG
    fi

    local docker_tag=$TRAVIS_REPO_SLUG:$commit
    if ! docker build -t "$docker_tag" .; then
        err "docker build of '$docker_tag' failed"
        return 1
    fi

    if [[ $TRAVIS_TAG =~ ^[0-9]+\.[0-9]+\.[0-9]+$ && $DOCKER_USER ]]; then
        if ! docker login -u "$DOCKER_USER" -p "$DOCKER_PASSWORD"; then
            err "docker login failed"
            return 1
        fi
        if ! docker push "$docker_tag"; then
            err "docker push of '$docker_tag' failed"
            return 1
        fi
    fi

    local git_tag=$commit+travis.$TRAVIS_BUILD_NUMBER
    if ! git config --global user.email "deploy@travis-ci.org"; then
        err "failed to set git user email"
        return 1
    fi
    if ! git config --global user.name "Travis CI"; then
        err "failed to set git user name"
        return 1
    fi
    if ! git tag "$git_tag" -m "Generated tag from Travis CI build $TRAVIS_BUILD_NUMBER"; then
        err "failed to create git tag: '$git_tag'"
        return 1
    fi
    local remote=origin
    if [[ $GITHUB_TOKEN ]]; then
        remote=https://$GITHUB_TOKEN:x-oauth-basic@github.com/$TRAVIS_REPO_SLUG.git
    fi
    if ! git push --quiet "$remote" "$git_tag" > /dev/null 2>&1; then
        err "failed to push git tag: '$git_tag'"
        return 1
    fi
}

main "$@" || exit 1
exit 0
