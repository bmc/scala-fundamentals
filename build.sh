#!/usr/bin/env bash

rm -rf out
mkdir out

for i in *.ipynb
do
  python strip_answers.py $i out/$i || exit 1
  mkdir out/answers
  cp $i out/answers
done
