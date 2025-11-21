#!/bin/bash

echo -n "Checking host environment ... "
sysname=`uname -s`
if echo $sysname | grep MINGW64; then
  arch=x86_64
elif echo $sysname | grep MINGW32; then
  arch=i686
else
  exit
fi

rm -f  tuxpaint-*-${arch}-installer.exe tuxpaint-*-${arch}.zip

echo "Building installer ... "
result=`/C/Program\ Files\ \(x86\)/Inno\ Setup\ 6/ISCC -DBuildTarget=${arch} tuxpaint.iss | grep ${arch}-installer.exe`
if [ "x$result" != "x" ]; then
  installer=`basename $result`
else
  exit
fi

echo "Building portable zip archive ... "
zip=`basename $installer '-installer.exe'`.zip
if [ -d TuxPaint ]; then
  rm -rf TuxPaint
fi
cp -a bdist TuxPaint
cp -a libdocs TuxPaint/docs/
zip -qr -9 $zip TuxPaint
rm -rf TuxPaint
