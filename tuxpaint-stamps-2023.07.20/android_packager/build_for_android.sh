#!/bin/sh

# build_for_android.sh
#
# Pere Pujal i Carabantes <pere@provant.freeddns.org>
# Minor edits Bill Kendrick <bill@newbreedsoftware.com>
# Last updated: 2021-08-07
#
# Calls "package_stamps.sh" to generate zip files with the images or sound descriptions and put them in the assets folder,
# and then calls "gradle" to build APK packages for Android


if [ "a$1b" = "ab" ]
then
    echo "Usage:"
    echo " * $0 images"
    echo "   Generates an assets 'stamps.zip' file with all the"
    echo "   images and metadata but without the language sound description files."
    echo " * $0 language_code"
    echo "   Generates an assets zip file with the"
    echo "   sound descriptions, then calls to generate the Android installer"
    echo "   for that language."
    echo " * $0 all"
    echo "   Build everything"
    echo
    echo "'language_code' may be one of:"
    echo " * english"
    find ../stamps/ -name "*desc_*.wav" -or -name "*desc_*.ogg" | sed -e "s/^.*_desc_//" -e "s/\....$//" | sort -u | sed -e "s/^/ * /"
    exit 1
fi


tmpdir="tmpdir"


if [ $1 = "images" -o $1 = "all" ]
then
    ./package_stamps.sh images
    gradle assembleImages
fi

if [ $1 = "be" -o $1 = "all" ]
then
    ./package_stamps.sh be
    gradle assembleSound_descriptions_be
fi
    
if [ $1 = "bg" -o $1 = "all" ]
then
    ./package_stamps.sh bg
    gradle assembleSound_descriptions_bg
fi

if [ $1 = "ca" -o $1 = "all" ]
then
    ./package_stamps.sh ca
    gradle assembleSound_descriptions_ca
fi

if [ $1 = "da" -o $1 = "all" ]
then
    ./package_stamps.sh da
    gradle assembleSound_descriptions_da
fi

if [ $1 = "el" -o $1 = "all" ]
then
    ./package_stamps.sh el
    gradle assembleSound_descriptions_el
fi

if [ $1 = "english" -o $1 = "all" ]
then
    ./package_stamps.sh english
    gradle assembleSound_descriptions_english
fi

if [ $1 = "es" -o $1 = "all" ]
then
    ./package_stamps.sh es
    gradle assembleSound_descriptions_es
fi

if [ $1 = "fr" -o $1 = "all" ]
then
    ./package_stamps.sh fr
    gradle assembleSound_descriptions_fr
fi

if [ $1 = "ml" -o $1 = "all" ]
then
    ./package_stamps.sh ml
    gradle assembleSound_descriptions_ml
fi

if [ $1 = "pt_BR" -o $1 = "all" ]
then
    ./package_stamps.sh pt_BR
    gradle assembleSound_descriptions_pt_BR
fi

if [ $1 = "ro" -o $1 = "all" ]
then
    ./package_stamps.sh ro
    gradle assembleSound_descriptions_ro
fi

if [ $1 = "ru" -o $1 = "all" ]
then
    ./package_stamps.sh ru
    gradle assembleSound_descriptions_ru
fi


mkdir -p $tmpdir/outputs/debug
mkdir -p $tmpdir/outputs/release

cp app/build/outputs/apk/*/debug/*apk $tmpdir/outputs/debug/

cp app/build/outputs/apk/*/release/*apk $tmpdir/outputs/release/

echo If all has gone fine, you will find the debug builds ready for testing in $tmpdir/outputs/debug
echo and the unsigned release builds in $tmpdir/outputs/release.

