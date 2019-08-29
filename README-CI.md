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
echo "firepress-org" > GITHUB_USER
```

Bypass the step `Define the version of the app` if it's too overkill for you.

**3) In your Github repo, add:**

It's under `settings/secrets`

```
DOCKER_PASSWORD

my_super_pass_in234itohw0e9gh
```

You see the beauty of this? Assuming you have a valid Dockerfile, you only have to set a few environment variables. You are doing CI like a chef and making the world a better place.

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
