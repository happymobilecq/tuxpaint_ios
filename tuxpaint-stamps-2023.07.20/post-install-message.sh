#!/bin/sh

echo
echo "All done! Now (preferably NOT as 'root' superuser),"
echo "you can type the command 'tuxpaint' to run the program and"
echo "see these stamps!!!"
echo
echo "For more information, see the 'tuxpaint' man page,"
echo "run 'tuxpaint --usage' or see README.txt"
echo
if [ -x "`which tuxpaint`" ]; then echo "Enjoy!"; else \
	echo "(Tux Paint doesn't appear to be installed, though!!!)"; fi
echo

