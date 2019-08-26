# [rclone](https://github.com/firepress-org/rclone-in-docker)

rclone in a docker container using CI (continuous integration)

**It features**:

- it builds **everyday** and every commits
- it builds from **go source**
- it uses **multi-stage**
- it uses **alpine** as final image
- it runs as **non-root**
- the app runs under **tiny**
- it push 4 **tags** on docker hub
- best practice **labels**
- it compress the app with **UPX**

<br>

## About rclone

[<img src="https://rclone.org/img/logo_on_light__horizontal_color.svg" width="50%" alt="rclone logo">](https://rclone.org/)

[GitHub](https://github.com/rclone/rclone/) |
[Website](https://rclone.org) |
[Documentation](https://rclone.org/docs/) |
[Download](https://rclone.org/downloads/) | 
[Installation](https://rclone.org/install/) |
[Forum](https://forum.rclone.org/)

Rclone *("rsync for cloud storage")* is a command line program to sync files and directories to and from different cloud storage providers.

At FirePress we use rclone to do cold storage backup outside our clusters.

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

At this moment (August 2019), it's tricky to use variables with Github Actions. [The issue](https://github.com/actions/starter-workflows/issues/68) is that when you set variable in an **action**, further actions can NOT use these variables. What!?

**Here is where the hack comes to play**. To avoid this limitation, we write variables on disk then `cat` them later. 

See the « Action » **A) Define VARs in** `./git_repo/.github/workflows/dockerfile_ci.yml`

From [Github docs](https://help.github.com/en/articles/virtual-environments-for-github-actions#github_token-secret):

![Screen Shot 2019-08-26 at 12 22 51 PM](https://user-images.githubusercontent.com/6694151/63705967-4da73300-c7fc-11e9-89c1-ca9390740337.jpg)

<br>

## Run the container

```
docker run --rm -it devmtl/rclone:1.49.0_2019-08-26_11H19s19_e89c3ce
```

<br>

## Docker hub

Always check on docker hub the most recent build:
https://hub.docker.com/r/devmtl/rclone/tags

Use the tag from this format:

```
1.49.0_2019-08-26_11H19s19_e89c3ce
```

The tag contains three information:
- version
- build date
- hash commit

<br>

&nbsp;

<p align="center">
    Brought to you by
</p>

<p align="center">
  <a href="https://firepress.org/">
    <img src="https://user-images.githubusercontent.com/6694151/50166045-2cc53000-02b4-11e9-8f7f-5332089ec331.jpg" width="340px" alt="FirePress" />
  </a>
</p>

<p align="center">
    <a href="https://firepress.org/">FirePress.org</a> |
    <a href="https://play-with-ghost.com/">play-with-ghost</a> |
    <a href="https://github.com/firepress-org/">GitHub</a> |
    <a href="https://twitter.com/askpascalandy">Twitter</a>
    <br /> <br />
</p>

&nbsp;

<br>

## Hosting

At FirePress we empower entrepreneurs and small organizations to create their websites on top of [Ghost](https://firepress.org/en/faq/#what-is-ghost).

At the moment, our **pricing** for hosting one Ghost website is $15 (Canadian dollars). This price will be only available for our first 100 new clients, starting May 1st, 2019 🙌. [See our pricing section](https://firepress.org/en/pricing/) for details.

More details [about this annoucement](https://forum.ghost.org/t/host-your-ghost-website-on-firepress/7092/1) on Ghost's forum.

<br>

## Contributing

The power of communities pull request and forks means that `1 + 1 = 3`. You can help to make this repo a better one! Here is how:

1. Fork it
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

Check this post for more details: [Contributing to our Github project](https://pascalandy.com/blog/contributing-to-our-github-project/). Also, by contributing you agree to the [Contributor Code of Conduct on GitHub](https://pascalandy.com/blog/contributor-code-of-conduct-on-github/). It's plain common sense really.

<br>

## License

- This git repo is under the **GNU V3** license. [Find it here](https://github.com/pascalandy/GNU-GENERAL-PUBLIC-LICENSE/blob/master/LICENSE.md).
- The Ghost’s software is under the **MIT** license. [Find it here](https://ghost.org/license/).

<br>


## Sources & Fork

- This Git repo is available at [https://github.com/firepress-org/ghostfire](https://github.com/firepress-org/ghostfire)
- Forked from the [official](https://github.com/docker-library/ghost/) Ghost image

<br>

## Why all this work?

Our [mission](https://firepress.org/en/our-mission/) is to empower freelancers and small organizations to build an outstanding mobile-first website.

Because we believe your website should speak up in your name, we consider our mission completed once your site has become your impresario.

For more info about the man behind the startup, check out my [now page](https://pascalandy.com/blog/now/). You can also follow me on Twitter [@askpascalandy](https://twitter.com/askpascalandy).

— The FirePress Team 🔥📰


