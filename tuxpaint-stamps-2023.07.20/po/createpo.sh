#!/bin/sh

set -e

# "createpo.sh" for Tux Paint Stmaps collection
# Last modified 2023-01-03

# Generate an updated translation template file for the
# stamp descriptions (".pot") based on the main English
# strings found in the text description files ("stampname.txt").
chmod 755 txt2pot.py
./txt2pot.py

# Unify any duplicate translations in the message catalog (".pot")
msguniq tuxpaint-stamps.pot | fgrep -v '#-#-#-#-#' > temp.tmp && mv -f temp.tmp tuxpaint-stamps.pot

# Merge the existing translations with the updated ".pot" file
for i in *.po ; do
  echo $i
  msgmerge --quiet --update --previous --no-wrap --backup=none $i tuxpaint-stamps.pot
  # Note: Not using --sort-output, since the POT should be in
  # the order of the stamp files themselves (by filename),
  # and that's much more useful than sorting by "msgid".
  # The PHP script "po-sorter.php" may be used to generate
  # a PO file that is forced to be in the same "msgid" order
  # as the POT file.  Use it with care, however.
done

msguniq --no-wrap --to-code=UTF-8 tuxpaint-stamps.pot > temp.tmp && mv -f temp.tmp tuxpaint-stamps.pot

