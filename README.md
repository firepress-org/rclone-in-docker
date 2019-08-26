# [rclone](https://github.com/firepress-org/rclone-in-docker)

rclone docker container.

# « Dockerfile CI everything » requirements

To « dockerfile CI everything » we need to keep a consistant format.

#### Dockerfile must include:

```
ARG APP_NAME="rclone"
ARG VERSION="1.49.0"
```

#### dockerfile_ci.yml




# Test image

```
docker run --rm -it devmtl/rclone:1.49.0
```