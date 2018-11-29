#!/usr/bin/env bash
set -e


#EJL8ZCTKLLJOB

DISTRIBUTION=$WEBGOALSHQ_CLOUDFRONT

echo
echo "  +====================+"
echo "  +====WEB GOALS HQ====+"
echo "  +====================+"
echo
echo "  This script will create and invalidation request on the AWS CloudFront distribution identified by the environment variable WEBGOALSHQ_CLOUDFRONT."
echo
echo "  The script has the following dependencies:"
echo
echo "- AWS CLI tool setup and configured with correct access to Web Goals HQ CloudFront distributions."
echo "- An environment variable WEBGOALSHQ_CLOUDFRONT with the name of the target S3 bucket"
echo

if [ -z $DISTRIBUTION ]; then
    echo "  The environment variable WEBGOALSHQ_CLOUDFRONT doesn't have a value. Set one with:"
    echo
    echo "     export WEBGOALSHQ_CLOUDFRONT=foo"
    echo
    exit 1
fi

if [ -x "$(command -v aws)" ]; then
    # Clear all the paths on CloudFront

    echo
    echo "  Requesting invalidation for all paths on CloudFront distribution $DISTRIBUTION."
    echo "  ..."
    aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION" --paths "/*"

else
    echo 'Cannot find AWS CLI, exiting'
    exit 1
fi