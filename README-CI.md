## README

[Back to README.md](./README.md)

## Introduction

Let's Dockerfile CI everything!

Assuming you have a valid Dockerfile, you only have to set a few environment variables directly in your Dockerfile and you will do CI like a chef and make the world a better place by the same token. 

To « dockerfile CI everything » we need to keep a consistent format by defining a few **variables**. Thanks to **Github Actions**, it's now very quick to set up a CI for your Dockerfile (and any kind of projects really).

This will help you to consistently build for every project you manage.

**1) Set variables in Dockerfile:**

```
ARG VERSION="3.2.0"
ARG APP_NAME="noti"
ARG DOCKERHUB_USER="devmtl"
ARG GITHUB_USER="firepress"
ARG GITHUB_ORG="firepress-org"
ARG GITHUB_REGISTRY="registry"
#
ARG USER="onfire"
ARG ALPINE_VERSION="3.10"
ARG GIT_REPO_URL="https://github.com/firepress-org/noti-in-docker"
ARG GIT_REPO_SOURCE="https://github.com/variadico/noti"
```

**2) Set secrets in your Github account:**

```
DOCKER_PASSWORD
```

```
# this is optional
TOKEN_SLACK
```

Location: `git_repo_name/settings/secrets`

**3) Your Dockerfile name is not standard?**

If you Dockerfile is difference than `Dockerfile`, change it in the YAML files under `/project_name/.github/workflows/*.yml`

<br>

## Hacking Github Actions

1/ Here is a great hack to use on your @github actions.

The pain is that when you set variables in a step in your workflow, further steps can NOT see the VAR 🙊.

Officially you have to re-set VAR at each step. This sucks.

Hold my beer 🍺

2/ Well, that sucked for about a day. Then I had 🙌🙌.

I found a way to hack this limitation. Write your VAR on disk (the CI system disk), then `cat $my_var` to use your VAR in every step you need 😎.

3/ Take a look at my yml file here -> https://github.com/firepress-org/rclone-in-docker/blob/master/.github/workflows/docker_build_ci.yml#L20

## Building from master VS from other branches

You'll find two YML files for that reason.

Cheers!
Pascal | https://twitter.com/askpascalandy
