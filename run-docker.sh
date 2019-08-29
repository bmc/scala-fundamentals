#!/usr/bin/env bash

prog=$(basename $0)
usage() {
  cat <<EOF >&2
Usage: $prog --help
       $prog [options] [bash]

OPTIONS

--help       Display this message and exit

-p port
--port port  Bind to <port> on the host. Default: 9999

-t tag
--tag tag    Use Docker image tag "tag". Defaults to "latest".

If you specify the "bash" argument, you'll be thrown into bash inside the
image (useful for debugging). Otherwise, the image will be run so that
you can connect to it from your browser.
EOF
  exit ${1:-1}
}

OPTS=$(getopt p:t: $*)

[ $? = 0 ] || usage
echo $OPTS

set -- $OPTS
tag=latest
port=9999

while true
do
  case $1 in
    -t|--tag)
      tag=$2
      shift
      shift
      ;;
    -p|--port)
      port=$2
      shift
      shift
      ;;
    --helo)
      usage 0
      ;;
    --)
      shift
      break
      ;;
    *)
      usage
      ;;
  esac
done

bash=
case $# in
  0)
    ;;
  1)
    if [ $1 != "bash" ]
    then
      usage
    fi
    bash=bash
    ;;
  *)
    usage
    ;;
esac


set -x
docker run -it --rm -p $port:8888 \
  -v `pwd`:/home/jovyan/scala-fundamentals \
  -v `pwd`/config/lab:/home/jovyan/.jupyter/lab \
  almondsh/almond:$tag $bash
