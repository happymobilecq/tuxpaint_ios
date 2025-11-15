#!/bin/bash

# find_missing_descs.sh


# This simple shell script looks for all stamps (PNG or SVG files)
# and reports which ones seem to lack a description (a corresponding TXT file).

# NOTE: It simply lists the names of the missing TXT files,
# rather than listing the PNGs or SVGs that lack TXT files.

# Bill Kendrick <bill@newbreedsoftware.com>
# 2007.02.15 - 2007.02.15


# "strstr()" function, from
# http://www.linuxvalley.it/encyclopedia/ldp/guide/abs/contributed-scripts.html
# By Noah Friedman

function strstr ()
{
    # if s2 points to a string of zero length, strstr echoes s1
    [ ${#2} -eq 0 ] && { echo "$1" ; return 0; }

    # strstr echoes nothing if s2 does not occur in s1
    case "$1" in
    *$2*) ;;
    *) return 0;;
    esac

    # use the pattern matching code to strip off the match and everything
    # following it
    first=${1/$2*/}

    # then strip off the first unmatched portion of the string
    return 1;
}


# Find all PNGs and SVGs
for i in `find ../stamps -name "*.png" -o -name "*.svg"`
do
  # Grab path of this file (because it's lost by basename)
  path=`dirname $i`

  # Call basename twice to yank off both .svg and .png from the end
  base=`basename "$i" .png`
  base=`basename "$base" .svg`

  # Ignore mirror and flip files (they use the main file's .txt file)
  strstr "$base" _mirror
  if [ $? -eq 1 ]; then { continue; } fi

  strstr "$base" _flip
  if [ $? -eq 1 ]; then { continue; } fi

  # See if this file has a corresponding .txt description file
  txt="$path/$base.txt"

  if [ ! -f "$txt" ]; then {
    echo "$txt";
  } fi
done
