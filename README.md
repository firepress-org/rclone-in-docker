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

# [rclone](https://github.com/firepress-org/rclone-in-docker)

## What is this?

**rclone** in a docker container along a CI (continuous integration) to build the Docker image.

## Features

- an **everyday build** and on every commit (CI)
- a build from the **sources** (CI)
- a logic of **four docker tags** on the master branch (CI) and logic of **three docker tags** on any other branches (CI)
- few UAT **tests** (CI)
- an automatic push of the **README** to Dockerhub (CI)
- **Slack** notifications when a build succeed (Job 2) (CI)
- a **multi-stage** build (Dockerfile)
- an **alpine** base docker image (Dockerfile)
- a **non-root** user (Dockerfile)
- having this app running as PID 1 under **tiny** (Dockerfile)
- **Labels** (Dockerfile)
- this app is compressed using **UPX** (Dockerfile)
- a **small footprint** docker image's size (Dockerfile)
- `utility.sh` based on [bash-script-template](https://github.com/firepress-org/bash-script-template)
- and probably more, but hey, who is counting?

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

## How to use it, Docker hub

<details><summary>Expand content (click here).</summary>
<p>

## How to use it

### Example 1

```
img_rclone="devmtl/rclone:1.49.1_2019-08-30_12H18s03_4984c21"

docker run -it --rm \
  --name rclone-runner \
  ${img_rclone}
```

or overide the default command:

```
img_rclone="devmtl/rclone:1.49.1_2019-08-30_12H18s03_4984c21"
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
img_rclone="devmtl/rclone:1.49.1_2019-08-30_12H18s03_4984c21"
run_this="rclone copy --transfers 10 --include ${FILE_TO_UPLOAD} /data ${B2_BUCKET_DESTINATION}"

docker run --rm \
  --name rclone-runner \
  -v /localpath/data:/data" \
  -v /localpath/rclone.conf:/home/usr_rclone/.config/rclone/rclone.conf \
  ${IMG_rclone} \
  sh -c "${run_this}"
```

## CI configuration & Github Actions

[See README-CI.md](./README-CI.md)

## Docker hub

Always check on docker hub the most recent build:<br>
https://hub.docker.com/r/devmtl/noti/tags

You should use **this tag format** in production.<br>
`${VERSION} _ ${DATE} _ ${HASH-COMMIT}` 

```
devmtl/rclone:1.49.1_2019-08-30_12H18s03_4984c21
```

These tags are also available to quickly test stuff:

```
docker run --rm -it devmtl/rclone:1.49.1
docker run --rm -it devmtl/rclone:stable
docker run --rm -it devmtl/rclone:latest
```

## Related docker images

[See README-related.md](./README-related.md)

</p>
</details>


## Website hosting

If you are looking for an alternative to WordPress, [Ghost](https://firepress.org/en/faq/#what-is-ghost) might be the CMS you are looking for. Check out our [hosting plans](https://firepress.org/en).

![ghost-v2-review](https://user-images.githubusercontent.com/6694151/64218253-f144b300-ce8e-11e9-8d75-312a2b6a3160.gif)


## Why, Contributing, License

<details><summary>Expand content (click here).</summary>
<p>

## Why all this work?

Our [mission](https://firepress.org/en/our-mission/) is to empower freelancers and small organizations to build an outstanding mobile-first website.

Because we believe your website should speak up in your name, we consider our mission completed once your site has become your impresario.

Find me on Twitter [@askpascalandy](https://twitter.com/askpascalandy).

— [The FirePress Team](https://firepress.org/) 🔥📰

## Contributing

The power of communities pull request and forks means that `1 + 1 = 3`. You can help to make this repo a better one! Here is how:

1. Fork it
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

Check this post for more details: [Contributing to our Github project](https://pascalandy.com/blog/contributing-to-our-github-project/). Also, by contributing you agree to the [Contributor Code of Conduct on GitHub](https://pascalandy.com/blog/contributor-code-of-conduct-on-github/). 

## License

- This git repo is under the **GNU V3** license. [Find it here](./LICENSE).

</p>
</details>
