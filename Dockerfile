ARG APP_NAME="rclone"
ARG VERSION="1.49.0"
ARG GIT_REPO="https://github.com/rclone/rclone/releases/download"
ARG ALPINE_VERSION="3.10"

# --- BUILDER GO -------------------------------
FROM golang:alpine${ALPINE_VERSION} AS gobuilder

ARG APP_NAME

# Install basics
RUN set -eux && apk --update --no-cache add \
    bash wget curl git openssl ca-certificates fuse tini upx

# Install Go dependencies
RUN set -eux && apk --update --no-cache add \
    -t build-deps curl libc-dev gcc libgcc

# Install app
# Warning, we install the latest version of the app regardless the $VERSION we defined earlier.
RUN go get -u -v github.com/rclone/"${APP_NAME}" && \
    # compress binary
    upx /go/bin/"${APP_NAME}" && \
    upx -t /go/bin/"${APP_NAME}" && \
    rclone --version

# --- FINAL LAYER -------------------------------
FROM alpine:${ALPINE_VERSION} AS final

ARG APP_NAME
ARG VERSION
ARG GIT_REPO
ARG ALPINE_VERSION

# Install basics
RUN set -eux && apk --update --no-cache add \
    openssl ca-certificates fuse tini

COPY --from=gobuilder /go/bin/"${APP_NAME}" /sbin/"${APP_NAME}"

ENV APP_NAME="${APP_NAME}"
ENV VERSION="${VERSION}"
ENV GIT_REPO="${GIT_REPO}"
ENV ALPINE_VERSION="{ALPINE_VERSION}"
ENV CREATED_DATE="$(date "+%Y-%m-%d_%HH%Ms%S")"
ENV SOURCE_COMMIT="$(git rev-parse --short HEAD)"

# Best practice credit: https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="${APP_NAME}"                                              \
      org.opencontainers.image.version="${VERSION}"                                             \
      org.opencontainers.image.description="not_set"                                            \
      org.opencontainers.image.authors="Pascal Andy https://firepress.org/en/contact/"          \
      org.opencontainers.image.vendors="https://firepress.org/"                                 \
      org.opencontainers.image.created="${CREATED_DATE}"                                        \
      org.opencontainers.image.revision="${SOURCE_COMMIT}"                                      \
      org.opencontainers.image.url="https://github.com/firepress-org/rclone-in-docker"          \
      org.opencontainers.image.source="https://github.com/firepress-org/rclone-in-docker"       \
      org.opencontainers.image.licenses="GNUv3 https://github.com/pascalandy/GNU-GENERAL-PUBLIC-LICENSE/blob/master/LICENSE.md" \
      org.firepress.image.user="usr_${APP_NAME}"                                                \
      org.firepress.image.field1="not_set"                                                      \
      org.firepress.image.field2="not_set"                                                      \
      org.firepress.image.schemaversion="1.0"

WORKDIR /sbin

# Run as non-root
RUN addgroup -S grp_"${APP_NAME}" && \
    adduser -S usr_"${APP_NAME}" -G grp_"${APP_NAME}" && \
    chown usr_"${APP_NAME}":grp_"${APP_NAME}" /sbin/"${APP_NAME}"
USER usr_"${APP_NAME}"

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "rclone", "--version" ]