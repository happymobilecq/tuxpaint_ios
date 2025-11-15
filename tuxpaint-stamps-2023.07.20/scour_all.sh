#!/bin/sh

for i in `find stamps -name "*.svg"`
do
  ls -l "$i"

  scour "$i" tmp.svg
  mv tmp.svg "$i"

  ls -l "$i"

  echo ------------------------------------------------------------------------------
done

