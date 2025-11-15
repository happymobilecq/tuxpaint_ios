#!/bin/sh

echo "...Installing '$1' stamp files..."
echo "   (to $2stamps/$1)"
echo
install -d "$2"stamps/$1
cp -R stamps/$1 "$2"stamps
# FIXME: chmod
