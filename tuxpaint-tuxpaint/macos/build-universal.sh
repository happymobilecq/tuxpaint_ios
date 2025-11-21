#!/usr/bin/env bash

function usage() {
    cat <<EOF
Build a macOS universal application bundle from one or more application
bundles.

Usage: ${SCRIPTNAME} [OPTIONS] TuxPaint-1.app TuxPaint-2.app ...

  TuxPaint-N.app        Bundle(s) to read.  If no bundles are specified, the
                        following files are read:
                        $(
                            for bundle in "${BUNDLES[@]}"; do
                                printf "\n%26s%s" "" "$bundle"
                            done
                        )

  -o OUTBUNDLE          Bundle to create.  [Default=${OUTBUNDLE}]

  -s IDENTITY           Re-sign the bundle with IDENTITY.  [Default=${IDENTITY}]

EOF
}


##############################################################################
# CONFIG

ARCHS=( arm64 x86_64 )
BUNDLES=( $(printf "TuxPaint-%s.app\n" "${ARCHS[@]}") )
OUTBUNDLE=TuxPaint.app
IDENTITY="-"
FORCE=0


##############################################################################
# PROGRAM BEGINS HERE

function main() {
    local OPTIND OPTARG OPTERR opt
    local bundle
    local isok=1

    # Process arguments
    while getopts "fo:s:h" opt; do
        case "$opt" in
            f)  FORCE=1           ;;
            o)  OUTBUNDLE=$OPTARG ;;
            s)  IDENTITY=$OPTARG  ;;
            h)  usage && exit 0   ;;
            *)  isok=0
        esac
    done
    shift $((OPTIND-1))

    # Use the specified bundles
    if (( $# )); then
        BUNDLES=( "$@" )
    fi

    # Sanity check
    if (( ! isok )); then
        usage 1>&2
        exit 1
    fi

    # Status
    echo "   * Creating universal app bundle $OUTBUNDLE by combining ${BUNDLES[*]}..."

    # Validate input
    for bundle in "${BUNDLES[@]}"; do
        if ! [[ -d "$bundle" ]]; then
            printf "     -> FAILED: No such input bundle named %s exists\n" "$bundle" 1>&2
            isok=0
        fi
    done
    (( isok)) || exit 1

    # Validate output
    if [[ -d "$OUTBUNDLE" ]] && (( FORCE )); then
        printf "     -> Deleting %s...\n" "$OUTBUNDLE"
        rm -rf "$OUTBUNDLE" || exitcode=1
    elif [[ -d "$OUTBUNDLE" ]]; then
        printf "     -> FAILED: Output bundled named %s already exists, use -f option to recreate.\n" "$OUTBUNDLE" 1>&2
        isok=0
    fi
    (( isok )) || exit 1

    build-universal
    resign-bundle
}


function build-universal() {
    local isok=1
    local i j

    # Create the base package without binaries or libraries
    echo "     -> Create skeleton app bundle ${OUTBUNDLE}..."     \
    && cp -a "${BUNDLES[0]}" "$OUTBUNDLE"                         \
    && rm -f "${OUTBUNDLE}/Contents/MacOS"/*                      \
    && find "$OUTBUNDLE" -name '*.dylib' -print0 | xargs -0 rm -f \
    || return 1

    # Create the universal binary for each binary and library
    for (( i=0; i < ${#BUNDLES[@]}; i++ )); do
        local filelist=()
        local file

        # Binaries
        for file in "${BUNDLES[i]}/Contents/MacOS"/*; do
            filelist+=( "${file#${BUNDLES[i]}/}" )
        done

        # Dynamic Libraries
        while IFS= read -r file; do
            filelist+=( "${file#${BUNDLES[i]}/}" )
        done < <(find "${BUNDLES[i]}" -name '*.dylib')

        # Build each as universal
        for file in "${filelist[@]}"; do
            local instances=()

            # Skip if already built
            [[ -e "${OUTBUNDLE}/${file}" ]] && continue

            # Get this file's instances in all bundles
            for (( j=i; j < ${#BUNDLES[@]}; j++ )); do
                if [[ -e "${BUNDLES[j]}/${file}" ]]; then
                    instances+=( "${BUNDLES[j]}/${file}" )
                fi
            done

            # Build into $OUTBUNDLE
            echo "     -> Combine ${file}..."
            lipo -create -output "${OUTBUNDLE}/${file}" "${instances[@]}" || isok=0
        done
    done

    (( isok ))
}


function resign-bundle() {
    echo "   * Sign $OUTBUNDLE..."
    codesign --remove-signature "$OUTBUNDLE"
    codesign -s "$IDENTITY" "$OUTBUNDLE"
    echo "     -> Done!"
}


##############################################################################
# ENTRY POINT

main "$@"
