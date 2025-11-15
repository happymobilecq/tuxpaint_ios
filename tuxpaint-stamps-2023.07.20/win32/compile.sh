#!/bin/bash

echo "Building installer ... "
result=`/C/Program\ Files\ \(x86\)/Inno\ Setup\ 6/ISCC -DBuildTarget=${arch} tuxpaint-stamps.iss | grep installer.exe`
echo $result

if [ "x$result" != "x" ]; then
  installer=`basename $result`
else
  exit
fi

echo $installer

echo "Building portable zip archive ... "
zip=`basename $installer '-installer.exe'`.zip
if [ -d TuxPaint ]; then
  rm -rf TuxPaint
fi
mkdir -p TuxPaint/{data/stamps,docs/stamps}
cp -a ../stamps/* TuxPaint/data/stamps/
cp -a ../docs/* TuxPaint/docs/stamps/
zip -qr -9 $zip TuxPaint
rm -rf TuxPaint
