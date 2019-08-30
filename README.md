# [rclone](https://github.com/firepress-org/rclone-in-docker)

rclone in a docker container using CI (continuous integration).

**It features**:

- it builds **[everyday](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/.github/workflows/docker_build_ci.yml#L8)** and on every commits
- it builds from the **[go sources](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/Dockerfile#L27)**
- it uses **multi-stage** build
- it uses **[alpine](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/Dockerfile#L47)** as final image
- it runs as **[non-root](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/Dockerfile#L70)**
- the app runs under **[tiny](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/Dockerfile#L90)**
- it push **[four tags](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/.github/workflows/docker_build_ci.yml#L113)** to registry
- it uses **[Labels](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/Dockerfile#L73)**
- it compress the app with **[UPX](https://github.com/firepress-org/rclone-in-docker/blob/2090107a0ea3382bee3cd43548c5a1ab79b5e333/Dockerfile#L33)**
- the docker image's size (uncompressed) is ~~ **26MB** ([commit](https://github.com/firepress-org/rclone-in-docker/commit/2090107a0ea3382bee3cd43548c5a1ab79b5e333))

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

<br>

## Regarding Github Actions & CI configuration

[See README-CI.md](./README-CI.md)

<br>

## Docker hub

Always check on docker hub the most recent build:<br>
[https://hub.docker.com/r/devmtl/rclone/tags](https://hub.docker.com/r/devmtl/rclone/tags)

You should use **this tag format** `$VERSION_$DATE_$HASH-COMMIT` in production.

```
devmtl/rclone:1.49.1_2019-08-30_12H18s03_4984c21
```

These tags are also available to quickly test stuff:

```
docker run --rm -it devmtl/rclone:1.49.1
docker run --rm -it devmtl/rclone:stable
docker run --rm -it devmtl/rclone:latest
```

<br>

## Running the container

### Example 1

```
img_rclone="1.49.1_2019-08-30_12H18s03_4984c21"

docker run -it --rm \
  --name rclone-runner \
  ${img_rclone}
```

or overide the default command:

```
img_rclone="1.49.1_2019-08-30_12H18s03_4984c21"
run_this="rclone --version"

docker run -it --rm \
  --name rclone-runner \
  -v /localpath/data:/data" \
  -v /localpath/rclone.conf:/home/usr_rclone/.config/rclone/rclone.conf \
  ${img_rclone} \
  sh -c "${run_this}"
```

### Example 2

Real life example to uplaod on B2

```
img_rclone="1.49.1_2019-08-30_12H18s03_4984c21"
run_this="rclone copy --transfers 10 --include ${FILE_TO_UPLOAD} /data ${B2_BUCKET_DESTINATION}"

docker run --rm \
  --name rclone-runner \
  -v /localpath/data:/data" \
  -v /localpath/rclone.conf:/home/usr_rclone/.config/rclone/rclone.conf \
  ${IMG_rclone} \
  sh -c "${run_this}"
```

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


