# gcloud-arm32v7

[![Build Status](https://travis-ci.org/ddgenome/gcloud-arm32v7.svg?branch=master)](https://travis-ci.org/ddgenome/gcloud-arm32v7)

Docker image of Google Cloud SDK providing the `gcloud` and `gsutil`
binaries for arm32v7/armhf. The image is based on
[resin/rpi-raspbian:jessie][raspbian] and installs google-cloud-sdk
from the [Google Cloud SDK APT repository][apt].

[raspbian]: https://hub.docker.com/r/resin/rpi-raspbian/ (Resin Raspberry Pi Debian)
[apt]: https://cloud.google.com/sdk/downloads#apt-get (Google Cloud SDK Installation - APT)

## Using

You can run this image directly:

```console
$ docker run -it --rm ddgenome/gcloud-arm32v7
```

or build a new image from it by using it as the `FROM` image in your
Dockerfile.

```dockerfile
FROM ddgenome/gcloud-arm32v7
```

## Building

This image is build on [Travis CI][travis].  To build this ARM Docker
image on x86 infrastructure, [QEMU][qemu] is used.  See [Setup a
simple CI pipeline to build Docker images for ARM][ci] for more details.

[travis]: https://travis-ci.org/ (Travis CI)
[qemu]: https://www.qemu.org/ (QEMU)
[ci]: https://blog.hypriot.com/post/setup-simple-ci-pipeline-for-arm-images/
