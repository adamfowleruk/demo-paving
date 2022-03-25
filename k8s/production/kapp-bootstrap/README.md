# kapp-bootstrap

A way to bootstrap a particular version of the kapp-controller into a vanilla
k8s environment.

Note: Each customer will need to run oci-build themselves for this as they
will need to accept EULA from Tanzu Net.

## What it does

- Builds the KappBootstrap image ('build' stage) - do this once in your organisation
  - Fetches the required CLI tools and verifies their SHAs
  - Logs in and fetches Tanzu Cluster Essentials (including kapp) from Tanzu Net
  - Packages this up using imgpkg to a tar file
- Runs the one-time kapp install routine ('run' stage) - do this when you create a new cluster
  - Copies TAR files and some CLI tooling from the build image
  - Runs imgpkg against the images from the tar files, adding them to a Harbor instance you specify
  - Runs the tanzu cli command to install the specified package (with rewritten image links)
  - Completes successfully if kubectl successfully applied the changes

Note from the above that this container itself shouldn't need root permissions.

