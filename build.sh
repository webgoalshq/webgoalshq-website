#!/usr/bin/env bash
set -e

PROJECT_DIR=$(cd `dirname $0` && pwd)
HUGO_VERSION="v0.49"

echo
echo "  +====================+"
echo "  +====WEB GOALS HQ====+"
echo "  +====================+"
echo

# check that we have the right version of hugo (if not, exit)
if [ -x "$(command -v hugo)" ]; then
    echo '  Found Hugo, checking version...'
    echo
    VERSION=$(hugo version | grep -o "v[0-9]*.[0-9]*")
    echo "  Local version is $VERSION. Checking support..."
    echo
    if [ $VERSION == $HUGO_VERSION ]; then
        echo "  SUCCESS. This script supports Hugo version $HUGO_VERSION. Let's go!"
        echo

        # Delete the public folder if it exists so we create a fresh build.
        if [ -d $PROJECT_DIR/public ]; then
            echo "  Removing previous build folder $PROJECT_DIR/public"
            rm -rf $PROJECT_DIR/public
        fi

        #echo build project
        echo
        echo "  Now running hugo command to build site..."
        hugo -s $PROJECT_DIR

        # remove .gitkeep from public folder (I'm not sure why it even exists)
        rm $PROJECT_DIR/public/.gitkeep

    else
        echo "When we run the 'hugo version' it says $VERSION but this script only supports $HUGO_VERSION."
        exit 1
    fi
else
    echo 'Cannot find Hugo, exiting'
    exit 1
fi