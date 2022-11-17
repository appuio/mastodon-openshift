# Mastodon Image for OpenShift

This repository contains a `Dockerfile` which modifies the [upstream](https://hub.docker.com/r/tootsuite/mastodon) image to be compatible with OpenShift.
As usual, it's a permission thingy.

Read more [here](https://docs.openshift.com/container-platform/4.11/openshift_images/create-images.html#images-create-guide-openshift_create-images) about why this is needed on OpenShift.

Get the image on [ghcr.io](https://github.com/appuio/mastodon-openshift/pkgs/container/mastodon-openshift%2Fmastodon):

```
docker pull ghcr.io/appuio/mastodon-openshift/mastodon:latest
```

## Image Maintenance

TODO Renovate and GitHub Action

## Helm Values

TODO add an example for the [upstream Chart](https://github.com/mastodon/mastodon/tree/main/chart)
