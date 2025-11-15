#!/bin/sh

# pngout is from http://www.jonof.id.au/kenutils.html

for i in `find stamps -name "*.png"`
do
  ls -l $i
  pngout -q $i
  ls -l $i
  echo ------------------------------------------------------------------------------
done

