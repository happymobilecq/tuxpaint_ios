Tux Paint Stamps Installer for macOS


REQUIREMENTS
------------
* macOS 11 Big Sur or later.
* Either the Intel or the Apple Silicon version of the Mac is fine.
* Xcode 12 or 13, the latest as of this writing.


BUILD INSTRUCTIONS
------------------
From the Terminal, run `make macos` in the directory above this directory to
create the app bundle and the DMG file.

Alternatively:

1. Open the Xcode project, update the MARKETING_VERSION, and archive the App
   Bundle.  The project may show tuxpaint-stamps.tar.gz as missing; it's ok,
   it'll be built by the "Run Script" Build Phase.

2. Once built, move "Tux Paint Stamps Installer.app" to the parent of this
   directory.

3. Optionally, `codesign -s <identity> "Tux Paint Stamps Installer.app"`

4. Run `make macos-dmg -o "Tux Paint Stamps Installer.app"` to build
   TuxPaint-Stamps-YYYY.MM.DD.dmg.

   The -o option is required to prevent make from rebuilding the App Bundle
   even though its timestamp will be older than its dependency,
   tuxpaint-stamps.tar.gz, a side effect of building tuxpaint-stamps.tar.gz via
   Xcode.


CREDITS
-------
Martin Fuhrer <mfuhrer@alumni.ucalgary.ca> is the original author of the macOS
port of the Tux Paint Stamps Installer.  It's since been reworked by other Tux
Paint contributors.

