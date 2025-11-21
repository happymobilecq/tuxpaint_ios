#!/bin/sh

# A wrapper around ImageMagick's `convert` so we can
# prevent it from using Inkscape to convert SVG files
# (which can pollute one's local filesystem with a fontcache;
# as reported by Tim Dickson, who helps maintain the
# Slackware version of the 'tuxpaint' package).
#
# Bill Kendrick <bill@newbreedsoftware.com>
# with input from Mark Kim, TOYAMA Shin-ichi, and Tim Dickson.
#
# Last modified: 2023-06-17

INPUT=`{
  shift \`expr $# - 2\`
  echo $1
}`
FILEEXT=`echo "$INPUT" | awk -F"." '{printf $NF}'`

if [ x$FILEEXT = "xsvg" ]; then
  # An SVG!

  # Create a dummy 'inkscape' that exits in such a way
  # that Imagemagick's `convert` will fallback to another
  # SVG converter, thus avoiding invoking the real Inkscape.
  echo "exit 1" > ./inkscape
  chmod +x ./inkscape
  
  # Add the local directory to the beginning of this script's
  # $PATH so `convert` finds the dummy script we just made.
  export PATH="`pwd`":"${PATH}"
  
  # Now run `convert` in the usual way (and grab its exit status,
  # so we don't catch `rm`'s)
  convert $@
  EXIT=$?
  
  # Clean up
  rm ./inkscape
else
  # Not an SVG (so, a PNG or JPEG); just run `convert` as usual.
  convert $@
  EXIT=$?
fi

exit $EXIT

