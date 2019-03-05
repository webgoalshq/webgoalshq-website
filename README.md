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

Codeship has been setup for automatic deployments to the staging website and the live website. To deploy to the staging site from your local machine you can run the following:

    $ ./deploy.sh draft

The deploy script will automatically run build.sh and 
