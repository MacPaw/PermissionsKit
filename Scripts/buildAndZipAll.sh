#!/bin/sh

function help() {
    echo "Usage: $(basename "$0") [-quiet]"
    echo "Options:"
    echo "  -quiet:             building scheme in quiet mode"
    echo "  -h, --help:         display this help"
    echo "Examples:"
    echo "  $(basename "$0") -quiet"
    exit 0
}

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PROJ_DIR="$(dirname "$SCRIPT_DIR")"
ARTIFACTS_DIR="$PROJ_DIR/artifacts"

QUIET=""

while [ $# -gt 0 ]
do
    case "$1" in
        -quiet)
            QUIET="-quiet"
            shift
            ;;
        -h|--help)
                help
            ;;
        *)
            echo "Unknown input parameter \"$1\". Run with --help or -h for help."
            exit 1
            ;;
    esac
done

check_utility_result()
{
    RESULT="$1"
    if [ $RESULT != 0 ]; then
        exit $RESULT
    fi
}

add_artifact()
{
    ARTIFACT="$1"
    mkdir -p "$ARTIFACTS_DIR"
    mv "$ARTIFACT" "$ARTIFACTS_DIR"
}

buildAndArchive()
{
    echo "------------ BUILD ------------"
    PROJECT="$PROJ_DIR/PermissionsKit.xcodeproj"
	SCHEME="PermissionsKit"
	BUILD_CONFIG="Release"
	DEBUG_INFORMATION_FORMAT="dwarf-with-dsym"
	SKIP_OBFUSCATION="NO"

    if [ ! -z "$QUIET" ]; then
        echo "Building scheme in quiet mode..."
        echo "\tCONFIGURATION = $BUILD_CONFIG"
        echo "\tDEBUG_INsFORMATION_FORMAT = $DEBUG_INFORMATION_FORMAT"
        echo "\tSKIP_OBFUSCATION = $SKIP_OBFUSCATION"
    fi

    xcodebuild clean build \
        $QUIET \
        -project "$PROJECT" \
        -scheme "$SCHEME" \
        -configuration "$BUILD_CONFIG" \
        DEBUG_INFORMATION_FORMAT="$DEBUG_INFORMATION_FORMAT" \
        SKIP_OBFUSCATION=$SKIP_OBFUSCATION
    check_utility_result $?

	PRODUCTS_DIR=$(xcodebuild -project "$PROJECT" \
	                          -scheme "$SCHEME" \
	                          -configuration "$BUILD_CONFIG" \
	                          -showBuildSettings \
                   | grep "BUILT_PRODUCTS_DIR" \
                   | grep -oEi "\/.*")
	
	echo "PRODUCTS_DIR = $PRODUCTS_DIR"
	cd "$PRODUCTS_DIR"

    ARTIFACTS=("PermissionsKit.framework" \
	           "PermissionsKit.framework.dSYM")
	for ARTIFACT in "${ARTIFACTS[@]}"
	do
		if [ -e "$ARTIFACT" ]; then
		    zip -r -y "$ARTIFACT.zip" "$ARTIFACT"; check_utility_result $?
			add_artifact "$ARTIFACT.zip"; check_utility_result $?
		fi
	done
}

rm -rf "$ARTIFACTS_DIR"
buildAndArchive

echo "Finished successfuly"
exit 0
