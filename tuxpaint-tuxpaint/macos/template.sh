#!/bin/bash

# 
# Process a document containing shell escape sequences.
#
# Usage: template.sh document.shdoc
#

bash <<<"cat <<__SHDOC_TEMPLATE__$$
$(cat "$@")
__SHDOC_TEMPLATE__$$"

# vim:ft=bash
