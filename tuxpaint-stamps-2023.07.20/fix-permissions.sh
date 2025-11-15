#!/bin/sh

echo "...Setting proper file permissions... (in $1)"
echo
chmod -R a+rX,g-w,o-w "$1"stamps
find "$1"stamps -type f -perm 755 -exec chmod 644 {} \;

