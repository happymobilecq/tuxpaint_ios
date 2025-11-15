#!/bin/sh

# "createtxt.sh" for Tux Paint Stmaps collection
# Last modified 2023-01-03

set -e

# Unify any duplicate translations
for i in *.po* ; do
  msguniq --no-wrap --to-code=UTF-8 $i > temp.tmp && mv -f temp.tmp $i
done

# Regenerate the stamp description text files ("stampname.txt")
# from translation files (".po")
chmod 755 po2txt.py
./po2txt.py
