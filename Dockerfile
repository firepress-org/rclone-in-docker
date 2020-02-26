# Those vars are used broadly outside this Dockerfile
# Github Action CI and release script (./utility.sh) is consuming these variables.

ARG VERSION="1.51.0"
ARG RELEASE="1.51.0-r1"
ARG APP_NAME="rclone"
ARG GITHUB_USER="firepress-org"
#
ARG ALPINE_VERSION="3.11"
#
ARG DOCKERHUB_USER="devmtl"
ARG GITHUB_ORG="firepress-org"
ARG GITHUB_REGISTRY="registry"
#
ARG GIT_REPO_DOCKERFILE="https://github.com/firepress-org/rclone-in-docker"
ARG GIT_REPO_SOURCE="https://github.com/rclone/rclone"


# ----------------------------------------------
# BASE IMAGE VERSIONNING LAYER
# ----------------------------------------------
FROM alpine:${ALPINE_VERSION} AS myalpine
FROM golang:alpine${ALPINE_VERSION} AS mygolang
# Credit to Tõnis Tiigi / https://bit.ly/2RoCmvG


# ----------------------------------------------
# ALPINEBASE LAYER
# ----------------------------------------------
FROM myalpine AS alpinebase

ARG APP_NAME
ARG VERSION

ARG ALPINE_VERSION
ARG GIT_REPO_DOCKERFILE
ARG GIT_REPO_SOURCE

ENV APP_NAME="${APP_NAME}"
ENV VERSION="${VERSION}"

ENV GIT_REPO_DOCKERFILE="${GIT_REPO_DOCKERFILE}"
ENV GIT_REPO_SOURCE="${GIT_REPO_SOURCE}"
ENV ALPINE_VERSION="${ALPINE_VERSION}"

ENV CREATED_DATE="$(date "+%Y-%m-%d_%HH%Ms%S")"
ENV SOURCE_COMMIT="$(git rev-parse --short HEAD)"

# Install basics
RUN set -eux && apk --update --no-cache add \
    ca-certificates tini

# Best practice credit: https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="${APP_NAME}"                                              \
      org.opencontainers.image.version="${VERSION}"                                             \
      org.opencontainers.image.description="See README.md"                                      \
      org.opencontainers.image.authors="Pascal Andy https://firepress.org/en/contact/"          \
      org.opencontainers.image.created="${CREATED_DATE}"                                        \
      org.opencontainers.image.revision="${SOURCE_COMMIT}"                                      \
      org.opencontainers.image.source="${GIT_REPO_DOCKERFILE}"                                  \
      org.opencontainers.image.licenses="GNUv3. See README.md"                                  \
      org.firepress.image.alpineversion="{ALPINE_VERSION}"                                      \
      org.firepress.image.field1="not_set"                                                      \
      org.firepress.image.field2="not_set"                                                      \
      org.firepress.image.schemaversion="1.0"


# ----------------------------------------------
# UPGRADE LAYER
# The point is to keep trace of logs our CI
# ----------------------------------------------
FROM alpinebase AS what-to-upgrade
RUN set -eux && apk update && apk upgrade


# ----------------------------------------------
# BUILDER LAYER
# ----------------------------------------------
FROM mygolang AS gobuilder

ARG APP_NAME
ARG VERSION

ARG GIT_REPO_SOURCE

ENV APP_NAME="${APP_NAME}"
ENV VERSION="${VERSION}"
ENV GIT_REPO_SOURCE="${GIT_REPO_SOURCE}"

# Install common utilities
RUN set -eux && apk --update --no-cache add \
    bash wget curl git openssl ca-certificates upx

# Install common Go dependencies
RUN set -eux && apk --update --no-cache add \
    -t build-deps libc-dev gcc libgcc

# Compile Go app
WORKDIR /go/src/github.com/rclone/rclone
RUN git clone "${GIT_REPO_SOURCE}" --single-branch --depth 1 -b "v${VERSION}" . && \
    git checkout -b "v${VERSION}" && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/"${APP_NAME}"

# Compress binary
RUN upx /usr/local/bin/"${APP_NAME}" && \
    upx -t /usr/local/bin/"${APP_NAME}" && \
    rclone --version

# ----------------------------------------------
# FINAL LAYER
# ----------------------------------------------
FROM alpinebase AS final

ARG APP_NAME
ENV APP_NAME="${APP_NAME}"

COPY --from=gobuilder /usr/local/bin/"${APP_NAME}" /usr/local/bin/"${APP_NAME}"

WORKDIR /usr/local/bin
VOLUME [ "/root/.config/rclone", "/data" ]
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "rclone", "--version" ]
