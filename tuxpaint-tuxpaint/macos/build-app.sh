#!/bin/sh

BUNDLE=TuxPaint.app
BINARY="$BUNDLE/Contents/MacOS/tuxpaint"
LIBS=`find $BUNDLE/Contents/Resources/lib -type f`
LIBDIR="$BUNDLE/Contents/lib"
CONF_FILES="macos/fonts.conf"
CONFDIR="$BUNDLE/Contents/Resources/etc"


# Sanity check
if [ ! -r "$BINARY" ]; then
	echo "$BINARY: Where is this file?" 1>&2 
	exit 1
fi

if [ ! -d "$BUNDLE" ]; then
	echo "$BUNDLE: Where is this file?" 1>&2 
	exit 1
fi

# Ensure the target folders exist
install -d -m 755 "$LIBDIR"
install -d -m 755 "$CONFDIR"

# Copy there any shared libraries referenced by the tuxpaint binary, and any
# shared libraries those shared libraries reference, and so on. We do this by
# first copying over any shared libraries referenced by the binary, then
# repeatedly copying over the shared libraries referenced by any libraries in
# the target folder until we don't see any more files appearing. There are
# better ways to do this than copying repeatedly but it works. And you know
# what they say about premature optimization...
dylib="$BINARY $LIBS"
count=0; last=-1
echo "   * Copying Shared Libraries..."
while [ $count -ne $last ]; do
	cp -p `otool -L $dylib | grep '^[[:space:]]*[/]opt[/]local[/]' | sed -e 's/^[[:space:]]*\([^[:space:]]*\)[[:space:]].*/\1/' | sort | uniq` $LIBDIR
	dylib="$LIBDIR/*"

	last=$count
	count=`ls -f $dylib | wc -l`
done
echo "     -> Copied" $count "files to $LIBDIR"

# We just copied over a bunch of shared libraries into a random folder in our
# app bundle, but the tuxpaint binary and the shared libraries won't know to
# look in that folder unless we tell them. So we tell them.
echo "   * Fixing Shared Library References..."
for i in "$BINARY" $LIBS $LIBDIR/*; do
	echo "     -> $i..."
	for j in `otool -L "$i" | grep '^[[:space:]]*[/]opt[/]local[/]' | sed -e 's/^[[:space:]]*\([^[:space:]]*\)[[:space:]].*/\1/'`; do
		n=`echo "$j" | sed 's/^[/]opt[/]local[/]/@executable_path\/..\//'`
		install_name_tool -change "$j" "$n" "$i"
	done

    # libSDL links to /System/Library/Frameworks/CoreGraphics.framework by
    # default on newer versions of macOS, but this library is located under
    # /System/Library/Frameworks/ApplicationServices.framework/Frameworks
    # instead in macOS 10.7, and is a symlink to its real location in later
    # versions of macOS.  For compatibility reasons, we tell libSDL to link to
    # the former location instead.  See here for more information:
    #
    # https://stackoverflow.com/questions/20206985/xcode-linking-against-applicationservices-framework-with-sdk-10-9-causes-10-7
    #
    if [ `otool -L "$i" | grep -c '^[[:space:]]*[/]System[/]Library[/]Frameworks[/]CoreGraphics\.framework[/]Versions[/]A[/]CoreGraphics'` -gt 0 ]; then
        defaultlib="/System/Library/Frameworks/CoreGraphics.framework/Versions/A/CoreGraphics"
        compatlib="/System/Library/Frameworks/ApplicationServices.framework/Frameworks/CoreGraphics.framework/Versions/A/CoreGraphics"
		install_name_tool -change "$defaultlib" "$compatlib" "$i"
    fi
done

# Some libraries require config files, so copy those...
echo "   * Copying Shared Library Configuration Files..."
for i in "$CONF_FILES"; do
	echo "     -> $i..."
	cp -p "$i" "$CONFDIR"
done

# Re-sign the bundle
#
# Apple Silicon requires all binaries that run natively to be signed.  For this
# reason, Xcode automatically signs all binaries built for Apple Silicon,
# anonymously if needed.  However, install_name_tool, which we use above,
# breaks the signature, so we need to resign the combined bundle.  We sign it
# anonymously using the identity named "-" (hyphen).  If the user has their own
# identity, they will need to sign it manually (after building the universal
# bundle, if one is being built).
#
# For more information on signature requirement on Apple Silicon, see:
# https://developer.apple.com/documentation/macos-release-notes/macos-big-sur-11_0_1-universal-apps-release-notes#:~:text=New%20in%20macOS,pass%20through%20Gatekeeper.
#
echo "   * Sign the app bundle with default identity..."
codesign --remove-signature "$BUNDLE"
codesign -s - "$BUNDLE"
echo "     -> Done!"

