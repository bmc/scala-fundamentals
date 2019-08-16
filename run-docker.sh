#!/usr/bin/env bash

usage() {
  echo "Usage: $0 [bash]" >&2
  exit 1
}

port_args=""
case "$#" in
  0)
    port_args="-p 9999:8888"
    ;;
  1)
    if [ $1 != "bash" ]
    then
      usage
    fi
    ;;
  *)
    usage
    ;;
esac

docker run -it --rm $port_args \
  -v `pwd`:/home/jovyan/scala-fundamentals \
  -v `pwd`/config/lab:/home/jovyan/.jupyter/lab \
  almondsh/almond:latest "$@"
