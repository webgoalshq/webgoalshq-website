# Web Goals HQ Website

Public facing website for Web Goals HQ.

## Local development

To setup a local development or content management environment you will need the following:

- Hugo version 0.49
- Node
- NPM

Clone the repository and then use Hugo on the command line to build the site and start local server:

    $ hugo server -D

(The "-D" will build the site with drafts enabled.)


## Theme development

TBD


## Deployment

There is a deploy.sh script you can use to deploy the website to Amazon S3. You need the following setup:

- Hugo v0.49
- Environment variables WEBGOALSHQ_S3 and WEBGOALSHQ_DRAFT_S3 for S3 bucket destinations
- AWS CLI tool

To deploy to the staging site from your local machine you can run the following:

    $ ./deploy.sh draft

The deploy script will automatically run build.sh and then sync the files to the Amazon S3. Removing the "draft" argument will deploy to the $WEBGOALSHQ_S3 target.
