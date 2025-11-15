#!/bin/sh

# package-stamps.sh
#
# This is called by the "build_for_android.sh" script.
#
# Pere Pujal i Carabantes <pere@provant.freeddns.org>
# Minor edits Bill Kendrick <bill@newbreedsoftware.com>
# Last updated: 2021-08-07
#
# Generates zip files with the images or sound descriptions and put them in the assets folder.
# The name of the generated zip file is always the same in order to let the associated android app compile withouth to much changes.


if [ "a$1b" = "ab" ]
then
    echo "Usage:"
    echo " * $0 images"
    echo "   Generates an assets 'stamps.zip' file with all the"
    echo "   images and metadata but without the language sound description files."
    echo " * $0 language_code"
    echo "   Generates a assets stamps.zip file with all the language sound"
    echo "   description files."
    echo
    echo "'language_code' may be one of:"
    echo " * english"
    find ../stamps/ -name "*desc_*.wav" -or -name "*desc_*.ogg" | sed -e "s/^.*_desc_//" -e "s/\....$//" | sort -u | sed -e "s/^/ * /"
    exit 1
fi


# Locations of things (relative to "android" subdir)

STAMPDIR="../stamps/"
PODIR="../po/"
tmpdir="tmpdir"


if [ $1 = "images" ]
then
  
    # Traverse the stamp categories / directories:

    echo -n "Scan for images and sound effects for $dir ...\t"

    # Grab all of the stamp imagery (.png & .svg),
    # settings (.dat), descriptive text (.txt), and
    # sound effects (.ogg & .wav),
    # but NOT the spoken descriptive sounds (*_desc*.wav & *_desc*.ogg) 
    find ${STAMPDIR} \
	 \( \
	 \( -name *.png -o -name *.svg -o -name *.txt -o -name *.dat -o -name *.ogg -o -name *.wav \) \
	 ! -name *_desc*.ogg \
	 ! -name *_desc*.wav \
	 \) \
	 -printf "install -D %p $tmpdir/stamps/%P\n" \
	| sort \
	| sh

else if [ $1 = "english" ]
then
  for desc in `find ${STAMPDIR} -name *desc.* -printf "%P\n" | sort`; do
    if [ "a${desc}b" != "ab" ]; then
      count=1
      install -D ${STAMPDIR}/$desc $tmpdir/stamps/$desc
    fi
  done

else

  # Scan for existing sound descriptions
  for desc in `find ${STAMPDIR}$dir -name "*desc_$1.*" -printf "%P\n" | sort`; do
    if [ "a${desc}b" != "ab" ]; then
      count=$(( $count + 1 ))
      install -D ${STAMPDIR}$desc $tmpdir/stamps/$desc
    fi
  done
fi
fi

# ZIP the dir, change to $1 directory to avoid having its path inside the zip
cd $tmpdir && \
    zip -qr tuxpaint-stamps.zip stamps && \
    cd .. && \
    SIZE=`stat -c %s $tmpdir/tuxpaint-stamps.zip` && \
    echo "Packaged into $tmpdir/tuxpaint-stamps.zip"

mv  $tmpdir/tuxpaint-stamps.zip app/src/main/assets/stamps.zip

# Clean up
rm -rf $tmpdir/stamps

