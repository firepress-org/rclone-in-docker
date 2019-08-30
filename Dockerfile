ARG APP_NAME="rclone"
ARG VERSION="1.49.1"
ARG GIT_REPO_DOCKERFILE="https://github.com/firepress-org/rclone-in-docker"
ARG GIT_REPO_SOURCE="https://github.com/rclone/rclone"
ARG ALPINE_VERSION="3.10"


# ----------------------------------------------
# BUILDER LAYER
# ----------------------------------------------
FROM golang:alpine${ALPINE_VERSION} AS gobuilder

ARG APP_NAME
ARG VERSION
ARG GIT_REPO_SOURCE

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

# Run as non-root
RUN addgroup -S grp_"${APP_NAME}" && \
    adduser -S usr_"${APP_NAME}" -G grp_"${APP_NAME}" && \
    chown usr_"${APP_NAME}":grp_"${APP_NAME}" /usr/local/bin/"${APP_NAME}"

# ----------------------------------------------
# FINAL LAYER
# ----------------------------------------------
FROM alpine:${ALPINE_VERSION} AS final

ARG APP_NAME
ARG VERSION
ARG GIT_REPO
ARG ALPINE_VERSION

ENV APP_NAME="${APP_NAME}"
ENV VERSION="${VERSION}"
ENV GIT_REPO_DOCKERFILE="${GIT_REPO_DOCKERFILE}"
ENV ALPINE_VERSION="{ALPINE_VERSION}"

ENV CREATED_DATE="$(date "+%Y-%m-%d_%HH%Ms%S")"
ENV SOURCE_COMMIT="$(git rev-parse --short HEAD)"

# Install basics
RUN set -eux && apk --update --no-cache add \
    ca-certificates tini

# Run as non-root
RUN addgroup -S grp_"${APP_NAME}" && \
    adduser -S usr_"${APP_NAME}" -G grp_"${APP_NAME}"

COPY --from=gobuilder --chown=usr_"${APP_NAME}":grp_"${APP_NAME}" /usr/local/bin/"${APP_NAME}" /usr/local/bin/"${APP_NAME}"

# Best practice credit: https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="${APP_NAME}"                                              \
      org.opencontainers.image.version="${VERSION}"                                             \
      org.opencontainers.image.description="See README.md"                                      \
      org.opencontainers.image.authors="Pascal Andy https://firepress.org/en/contact/"          \
      org.opencontainers.image.created="${CREATED_DATE}"                                        \
      org.opencontainers.image.revision="${SOURCE_COMMIT}"                                      \
      org.opencontainers.image.source="${GIT_REPO_DOCKERFILE}"                                  \
      org.opencontainers.image.licenses="GNUv3. See README.md"                                  \
      org.firepress.image.user="usr_${APP_NAME}"                                                \
      org.firepress.image.alpineversion="{ALPINE_VERSION}"                                      \
      org.firepress.image.field1="not_set"                                                      \
      org.firepress.image.field2="not_set"                                                      \
      org.firepress.image.schemaversion="1.0"

USER usr_"${APP_NAME}"
WORKDIR /usr/local/bin
VOLUME /data
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "rclone", "--version" ]