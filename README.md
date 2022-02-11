# demo-paving

Paving Concourse pipelines for different environments. This is used in my
YouTube "Developer Experience" DevOps video series:
https://youtube.com/c/adamfowleruk

_Don't you mean DevSecOps?_: No I don't! Putting 'Sec' in something doesn't
magically make it secure. If you're not putting 'Sec' in all of your daily
activities already, then calling something DevSecOps instead of DevOps won't
fix security issues. Practically, there is no difference between DevOps
and DevSecOps if you're doing your job properly in the first place! Here
endeth the rant.

The files in here are intended to be used standalone, but do link out
to other repositories for the demo applications used to test and install
the built OCI container images.

## Repository contents

Each folder is for a different type of deliverable:-

- app-pipeline - Used for Concourse CI/CD pipeline templates
- helm - Custom helm charts for my apps in other repositories. I use helm for packaging wherever possible.
- k8s - Raw K8S configuration for individual components, or environment extensions, not part of a helm chart
- tap - Tanzu Application Platform (TAP) catalogues for Backstage

## Helm apps provided

This repository is also the home for all of my helm charts. It was easier
than creating a myriad of very small helm git repos for each app. Here
are the apps that currently have helm charts:-

- adsb-fullstack - Aircraft tracking demo with live data incorporating java 
(not yet .NET) and microservices, a ReactJS web app, and backing data services 
including RabbitMQ and Postgresql.

## Environment targets for each deliverable

Each folder contains a subfolder intended for a different type of environment, as follows:-

- develop - Used to try out new changes when building new release versions of remote
software (I.e. the develop branch of remote applications)
- test - Used for the testing of new software or OS versions before they are
promoted and deployed to shared environments or production. Should also be used
for shared developer environments.
- production - Once tested and passed, should be used for pre-production testing
and production environments

***WARNING***: My 'production' is purely for my fake, demo, production-like
environment. No software in this or other repositories should be regarded as
production grade. I often use older and insecure configurations for demo purposes
so I can reproduce and show security issues, and talk about continuous integration
and upgrades.

## Subfolders versus branches

This repository has subfolders called 'develop' and 'production' but also has 'main',
'develop' and feature branches. The distinction of these branches in THIS repository
are below:-

- feature-ISSUENUM - Where I'm creating new helm charts, or updates to pipelines. 
ISSUENUM is the GitHub issue number this in progress work relates to. Go read that 
issue for details. Tested on my shared test environment
- develop - Once the content of THIS repository works on the test environment,
this branch will be used to test new features automatically on others' environments.
Use this branch if you want the latest features of this repo tested against your
own environments
- main - My release branch. When I'm confident my pipeline changes run everywhere,
I'll promote them to the main branch. Use this if you want well tested content.

## Subfolder and branch combinations

It's hard to get your head around branches vs. subfolders in GitOps workflows.
Here's how I get my head around the differences:-

- main branch, test subfolder - Configuration that is well tested, but intended
to be deployed to test environments. This may include, for example, application
buildpacks with verbose logging enabled.
- developer branch, production subfolder - New configuration changes I'm testing
out on other environments but which is intended as configuration for production
environments. These will likely remove verbose logging, deploy no CI app test
containers, and have locked down URL endpoints.
- main branch, production subfolder - Well tested configuration intended for
'production' environments.

Note that my 'production' subfolders don't ever assume a public internet connection
so if you need to deploy or run containers on segregated networks, such as those
behind security Diodes on government systems, these are intended for those
environments. They typically fetch content used from private Harbor repositories
or other source such as S3 or Artifactory that can be hosted on disconnected systems.

***WARNING***: Again, my 'production' is purely for my fake, demo, production-like
environment. No software in this or other repositories should be regarded as
production grade. I often use older and insecure configurations for demo purposes
so I can reproduce and show security issues, and talk about continuous integration
and upgrades.

## Why some subfolders are missing

This repo is intended just for demo purposes. If I don't need to demo
the differences between develop / test / production, then there will only
be one subfolder. If its production it may mean less logging than develop.
That is generally the only distinction as to which I choose.

## License

All files in this repository are licensed under Apache-2.0.