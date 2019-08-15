# Scala Fundamentals Jupyter notebooks

Right now, the easiest way to run these things is:

- Check out the repo.

- Make sure you have Docker installed.
    - Use [Docker Desktop](https://www.docker.com/products/docker-desktop)
      on Mac or Windows.
    - On Linux, use whatever is appropriate to your distro.

- Pull the `almondsh/almond:latest` image (`docker pull almondsh/almond:latest`)

- Fire it up, mapping your local copy of this repo to some directory in
  the container. Here, I assume you've done a `cd` into the repo directory,
  and you're mapping it to `scala-fundamentals` in the container.

```
docker run -it --rm -p 8888:8888 -v `pwd`:/home/jovyan/scala-fundamentals almondsh/almond:latest
```

- Once it's up, look for the printed output on the console that looks something
like this:

```
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://(03586dcd6c08 or 127.0.0.1):8888/?token=b341e69f3a8f4188907fa041e524074fb389b80c6f0da1a9
```

- Copy the `token=blahblahblah` part. Then, connect to
  `http://localhost:8888/labs?token=blahblahblah`

- The Jupyter Labs interface should come up. Drill down into the
  `scala-fundamentals` folder, and you should be able to open any of
  the notebooks.

- If you need to set a kernel, use Scala 2.11 for now. It seems to be
  the most stable.

**Note**: The REPL that backs the Jupyter notebook is Ammonite, not the
Scala REPL. Most of the Ammonite coolness should work.

## Generating notebooks for a workshop or class

Run the `build.sh` script. It uses the `strip_answers.py` script to create
versions of the notebooks without ANSWER cells in an `out` subdirectory, as
well as copying the original notebooks to `out/answers`.

(This procedure may be enhanced later.)
complete original notebooks into 
