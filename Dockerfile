FROM arm32v7/debian:jessie

MAINTAINER David Dooling <dooling@gmail.com>

RUN apt-get update && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

ENV CLOUD_SDK_REPO=cloud-sdk-jessie

COPY google-cloud-sdk.list /etc/apt/sources.list.d/google-cloud-sdk.list

RUN apt-get update && apt-get install -y \
        google-cloud-sdk \
    && rm -rf /var/lib/apt/lists/*
