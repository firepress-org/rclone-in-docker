## README

[Back to README.md](./README.md)

## « Dockerfile CI everything » requirements

You see the beauty of this? Assuming you have a valid Dockerfile, you only have to set a few environment variables. You are doing CI like a chef and making the world a better place. 

To « dockerfile CI everything » we need to keep a consistent format by defining a few **variables**. Thanks to **Github Actions**, it's now very quick to set up a CI for your Dockerfile (and every project really).

This will help you to consistently build for every project you manage.

**1) Dockerfile:**

```
ARG APP_NAME="rclone"
ARG VERSION="1.49.0"
```

**2) In the dockerfile_ci.yml**

```
## to push on dockerhub
echo "devmtl" > DOCKERHUB_USER
echo "Dockerfile" > DOCKERFILE_NAME

## to push on Github Package Registry (GPR)
echo "firepress" > GITHUB_USER
echo "firepress-org" > GITHUB_ORG
echo "registry" > GITHUB_REGISTRY
```

Location: `./git_repo/.github/workflows/dockerfile_ci.yml`

**3) Secret your Github account:**

```
DOCKER_PASSWORD
```

Location: `settings/secrets`

<br>

## Hacking Github Actions

1/ Here is a great hack to use on your @github actions.

The pain is that when you set variables in a step in your workflow, further steps can NOT see the VAR 🙊.

Officially you have to re-set VAR at each step. This sucks.

Hold my beer 🍺

2/ Well, that sucked for about a day. Then I had 🙌🙌.

I found a way to hack this limitation. Write your VAR on disk (the CI system disk), then `cat $my_var` to use your VAR in every step you need 😎.

3/ Take a look at my yml file here -> https://github.com/firepress-org/rclone-in-docker/blob/master/.github/workflows/docker_build_ci.yml#L20

You'll be a CI ninja for Docker in no time 👊.

## Docker history log

I included an docker history in the CI. This is only to show how efficient this build is. Per example:

```
docker history devmtl/rclone:1.49.1_2019-08-30_00H37s29_d5e6b51

IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT

<missing>           7 minutes ago       /bin/sh -c #(nop) COPY --chown=usr_rclone:gr…   19.7MB
<missing>           7 minutes ago       /bin/sh -c addgroup -S grp_"${APP_NAME}" && …   4.88kB
<missing>           7 minutes ago       /bin/sh -c set -eux && apk --update --no-cac…   578kB
<missing>           7 weeks ago         /bin/sh -c #(nop) ADD file:0eb5ea35741d23fe3…   5.58MB
```

In plain english:

```
copy rclone binary from the previous stage
set user group
install tini
alpine:3.10
```