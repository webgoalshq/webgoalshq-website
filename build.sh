#!/usr/bin/env bash
set -e

PROJECT_DIR=$(cd `dirname $0` && pwd)
HUGO_VERSION="v0.49"

echo $PROJECT_DIR

# check that we have the right version of hugo (if not, exit)
if [ -x "$(command -v hugo)" ]; then
    echo 'Found Hugo, checking version...';
    VERSION=$(hugo version | grep -o "v[0-9]*.[0-9]*")
    echo 'Local hugo version is ' . $VERSION
else
    echo 'Cannot find MkDocs, exiting';
    exit 1;
fi