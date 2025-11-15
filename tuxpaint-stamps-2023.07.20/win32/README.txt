Building Tux Paint Stamps installer
===================================

You need Python 2.3.3 or later installed (might work with earlier versions).
Using a DOS box or Command-Prompt cd into visualc dir and run 
'python prebuild.py'. This will format the text documentation, and build a
filelist used by the NSIS installer.

You need to have downloaded and installed NSIS-2 from here:
http://nsis.sourceforge.net/

The easiest way of running the script is to right-click on it in the Windows
Explorer and choose "Compile NSIS Script". The compression defaults to 
LZMA, which consistantly gaves the best results (smallest installer).

The first few lines in 'tuxpaint-stamps.nsi' currently need manual editing to
make sure that the installer has the right name (this keeps bill happy:-)

John Popplewell.
john@johnnypops.demon.co.uk
http://www.johnnypops.demon.co.uk/

