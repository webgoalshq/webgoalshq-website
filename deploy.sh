#!/usr/bin/env bash
set -e

PROJECT_DIR=$(cd `dirname $0` && pwd)
DESTINATION=$WEBGOALSHQ_S3
DESTINATION_DRAFT=$WEBGOALSHQ_DRAFT_S3
DRAFT_FLAG=$1
TARGET=""

echo
echo "  +====================+"
echo "  +====== DEPLOY ======+"
echo "  +====================+"
echo
echo "  This deploy script will run the build.sh script in this project and then sync the files to an S3 bucket."
echo
echo "  The script has the following dependencies:"
echo
echo "- AWS CLI tool setup and configured with correct access to Web Goals HQ S3 buckets"
echo "- An environment variable WEBGOALSHQ_S3 with the name of the target S3 bucket."
echo "- An environment variable WEBGOALSHQ_DRAFT_S3 with the name of the test S3 bucket."
echo

if [ -x "$(command -v aws)" ]; then

    echo "  AWS CLI found... moving forward."
    echo

else
    echo 'Cannot find AWS CLI, exiting'
    exit 1
fi

# Set S3 target based on draft flag.

if [ "$DRAFT_FLAG" == "draft" ]; then
    # Build and deploy for draft
    if [ -z $DESTINATION_DRAFT ]; then
        echo "  The environment variable WEBGOALSHQ_DRAFT_S3 doesn't have a value. Set one with:"
        echo
        echo "     export WEBGOALSHQ_DRAFT_S3=foo"
        echo
        exit 1
    else
        TARGET=$DESTINATION_DRAFT
        
        echo "  Using WEBGOALSHQ_DRAFT_S3 environment variable for S3 target."
        echo
        echo "  Building fresh site with 'build.sh draft'"
        echo

        $PROJECT_DIR/build.sh draft
        aws s3 sync $PROJECT_DIR/public/ s3://$TARGET --delete

        echo "  All finished!"
        echo
    fi
else
    # Build and deploy for prod.
    if [ -z $DESTINATION ]; then
        echo "  The environment variable WEBGOALSHQ_S3 doesn't have a value. Set one with:"
        echo
        echo "     export WEBGOALSHQ_S3=foo"
        echo
        exit 1
    else
        TARGET=$DESTINATION
        
        echo "  Using WEBGOALSHQ_S3 environment variable for S3 target."
        echo
        echo "  Building fresh site with 'build.sh'"

        $PROJECT_DIR/build.sh
        aws s3 sync $PROJECT_DIR/public/ s3://$TARGET --delete

        echo "  All finished!"
        echo
    fi
fi
