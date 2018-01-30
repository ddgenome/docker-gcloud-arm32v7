FROM resin/rpi-raspbian:jessie

MAINTAINER David Dooling <dooling@gmail.com>

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

ENV CLOUD_SDK_REPO=cloud-sdk-jessie

COPY google-cloud-sdk.list /etc/apt/sources.list.d/google-cloud-sdk.list

RUN apt-get update && apt-get install -y \
        google-cloud-sdk \
        gcc python-dev python-setuptools python-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip uninstall -y crcmod ; pip install -U crcmod
