# Scala Fundamentals Jupyter notebooks

This repo contains Jupyter versions of the notebooks used in the
Philly Area Scala Enthusiasts' Scala Fundamentals Workshop.

The [original notebooks](https://github.com/scala-phase/scala-fundamentals) are
usable only in Databricks (e.g., in
[Databricks Community Edition](https://databricks.com/ce)).

This repo serves several purposes:

- It contains Jupyter versions of the notebooks, which can be used in local
  Jupyter (or JupyterLabs) installations, Docker-based instances, or even
  in JupyterHub. Jupyter is a highly popular, open source platform with
  a rich ecosystem of tools. GitHub can even statically render Jupyter notebooks
  directly.
- The notebooks in this repo follow the basic outline and structure of the
  original workshop material, but some of the content has been updated and/or
  changed a bit.

## Running or Editing the Notebooks Locally

Right now, the easiest way to run and edit these notebooks is to use Docker.
There's a Docker image, `almondsh/almond` (from [Almond](https://almond.sh/)) that provides:

- a ready-to-run JupyterLabs instance
- with a Jupyter kernel supporting Scala 2.11 and 2.12 (with 2.13 support
  currently in development)
- using [Ammonite](https://ammonite.io) as the backing REPL.

Using this Docker image means you're using the exact same environment I'm
using to rework this material.

### Setup

Here's what you do.

- Make sure you have Docker installed.
    - Use [Docker Desktop](https://www.docker.com/products/docker-desktop)
      on Mac or Windows.
    - On Linux, use whatever is appropriate to your distro.

- Clone this repo to your local machine.

- Pull the `almondsh/almond:latest` image:

```shell
$ docker pull almondsh/almond:latest
```

- `cd` into the repo directory.

- Use `./run-docker.sh` to start the Docker image. The script:
    - mounts the current working directory to `scala-fundamentals` in the image
    - mounts the `config/lab` directory into `~/.jupyter/config/lab` in the
      image (to override certain configuration settings, such as the default
      auto-indentation of 4)
    - maps the port Jupyter uses in the container to port 9999 on your local
      machine

```
$ ./run-docker.sh
```

- Once it's up, look for the printed output on the console that looks something
  like this:

```
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://(03586dcd6c08 or 127.0.0.1):8888/?token=b341e69f3a8f4188907fa041e524074fb389b80c6f0da1a9
```

- Copy the `token=blahblahblah` part. Then, connect to
  `http://localhost:9999/lab?token=blahblahblah`

- The Jupyter Labs interface should come up. Drill down into the
  `scala-fundamentals` folder, and you should be able to open any of
  the notebooks.

- If you need to set a kernel, use Scala 2.11 for now. It seems to be
  the most stable. I plan to switch to Scala 2.13, when the Almond project
  supports it.

**Reminder**: The REPL that backs the Jupyter notebook is Ammonite, not the
Scala REPL. Most of the Ammonite coolness should work.

## Generating notebooks for a workshop or class

Run the `build.sh` script. It uses the `strip_answers.py` script to create
versions of the notebooks without ANSWER cells in an `out` subdirectory, as
well as copying the original notebooks to `out/answers`.

(This procedure may be enhanced later.)

An ANSWER code cell is designed to provide the answer to an exercise the students
are supposed to try to complete. To mark a code cell as an ANSWER cell, just
include a line that starts with `// ANSWER`.

---
```
val inventory = 50
val result = ??? // fill this in
```
---
```
// ANSWER
val inventory = 50
val result = if (inventory >= 50) {
  "In stock"
}
else if (inventory > 10 && inventory < 50) {
  "Less than 50 remaining"
}
else if (inventory > 0 && inventory <= 10) {
  "Only a few left!"
}
else if (inventory == 0) {
  "Out of stock"
}
```

The build script will produce student versions of the notebooks, without
the ANSWER cells. It'll also copy the original notebooks (_with_ the answer
cells) into `out/answers`.
