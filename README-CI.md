## README

[See README.md](./README.md)

## « Dockerfile CI everything » requirements
To « dockerfile CI everything » we need to keep a consistent format by defining a few **variables**. Thanks to **Github Actions**, it's now very quick to set up a CI for your Dockerfile (and every project really). By setting these variables, your Dockerfile will build consistently for every project you manage.

**1) In the Dockerfile, update:**

```
ARG APP_NAME="rclone"
ARG VERSION="1.49.0"
```

**2) In the dockerfile_ci.yml, update:**

It's under `./git_repo/.github/workflows/dockerfile_ci.yml`

```
echo "devmtl" > DOCKERHUB_USER
```

**3) In the Github repo, add:**

It's under `settings/secrets`

```
DOCKER_PASSWORD
```

You see the beauty of this? Assuming you have a valid Dockerfile, you only have to set four environment variables, and you are doing CI like a chef and making the world a better place.

<br>

## Hacking Github Actions

**Github actions and environment variables**

The issue IMHO, is that when you set variables in an action, further actions can NOT consume these variables. See [Github docs](https://help.github.com/en/articles/virtual-environments-for-github-actions#github_token-secret) about this.

I found a way to hack this limitation.

We write variables on disk then cat them later. So simple :-p

See the « Action » **A) Define VARs in** `./git_repo/.github/workflows/dockerfile_ci.yml`


