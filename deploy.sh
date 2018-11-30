#!/usr/bin/env bash
set -e

PROJECT_DIR=$(cd `dirname $0` && pwd)
DESTINATION=$WEBGOALSHQ_S3

echo
echo "  +====================+"
echo "  +====WEB GOALS HQ====+"
echo "  +====================+"
echo
echo "  This deploy script will look for a '/public' folder in this project and then sync the files to an S3 bucket."
echo
echo "  The script has the following dependencies:"
echo
echo "- AWS CLI tool setup and configured with correct access to Web Goals HQ S3 buckets"
echo "- An environment variable WEBGOALSHQ_S3 with the name of the target S3 bucket"
echo

if [ -z $DESTINATION ]; then
    echo "  The environment variable WEBGOALSHQ_S3 doesn't have a value. Set one with:"
    echo
    echo "     export WEBGOALSHQ_S3=foo"
    echo
    exit 1
fi

if [ -x "$(command -v aws)" ]; then
    # need a prompt here for confirmation

    # Delete the public folder if it exists so we create a fresh build.
    if [ -d $PROJECT_DIR/public ]; then
        echo
        echo "  Site folder /public found. Syncing to s3://$DESTINATION"
        echo "  ..."
        aws s3 sync $PROJECT_DIR/public/ s3://$DESTINATION --delete
    fi

else
    echo 'Cannot find AWS CLI, exiting'
    exit 1
fi