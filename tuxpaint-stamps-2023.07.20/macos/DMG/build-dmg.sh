#!/bin/bash

##############################################################################
# Script to generate tuxpaint-stamps.dmg from Tux Paint Stamps Installer.app.
#
# Generating a pretty DMG file programmatically is a bit of an art.  Many
# thanks to the appdmg project for showing how:
# (https://github.com/LinusU/node-appdmg)
#

BUNDLE="Tux Paint Stamps Installer.app"
TEMP_DMG=temp.dmg
TEMP_DMG_SIZE=`expr \`du -sm "$BUNDLE" | cut -f1\` \* 15 / 10`m
VER_DATE=`date +"%Y.%m.%d"`
FINAL_DMG="TuxPaint-Stamps-$VER_DATE.dmg"
VOLNAME="Tux Paint Stamps"
ICON="macos/Tux Paint Stamps Installer/tuxpaint.icns"
BACKGROUND="macos/background.png"


echo "   * Creating the temporary image..."
hdiutil create "$TEMP_DMG" -ov -fs HFS+ -size "$TEMP_DMG_SIZE" -volname "$VOLNAME" \
&& VOLUME=`hdiutil attach "$TEMP_DMG" -nobrowse -noverify -noautoopen | grep Apple_HFS | sed 's/^.*Apple_HFS[[:blank:]]*//'` \
|| exit 1

# No background
# echo "   * Adding the image background..."
# mkdir "$VOLUME/.background" \
# && tiffutil -cathidpicheck "$BACKGROUND" -out "$VOLUME/.background/background.tiff" \
# || exit 1

echo "   * Setting the folder icon..."
cp "$ICON" "$VOLUME/.VolumeIcon.icns" \
&& /usr/bin/SetFile -a C "$VOLUME" \
|| exit 1

echo "   * Copying the contents..."
cp -a "$BUNDLE" "$VOLUME" \
&& cp -a "macos/DMG/Read Me.rtf" "$VOLUME/Read Me.rtf" \
&& cp -a "macos/DMG/DS_Store" "$VOLUME/.DS_Store" \
|| exit 1

echo "   * Configuring the folder to open upon mount..."
if [[ "$(uname -m)" == "arm64" ]]; then
    bless --folder "$VOLUME"
else
    bless --folder "$VOLUME" --openfolder "$VOLUME"
fi || exit 1

echo "   * Unmounting the temporary image..."
hdiutil detach "$VOLUME"

echo "   * Creating the final image..."
hdiutil convert "$TEMP_DMG" -ov -format "UDBZ" -imagekey "zlib-level=9" -o "$FINAL_DMG"

echo "   * Deleting the temporary image..."
rm -f "$TEMP_DMG"

