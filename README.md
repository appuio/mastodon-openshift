# Mastodon Image for OpenShift

This repository contains a `Dockerfile` which modifies the [upstream](https://hub.docker.com/r/tootsuite/mastodon) image to be compatible with OpenShift.
As usual, it's a file permission thingy.

Read more [here](https://docs.openshift.com/container-platform/4.11/openshift_images/create-images.html#images-create-guide-openshift_create-images) about why this is needed on OpenShift.

Get the image on [ghcr.io](https://github.com/appuio/mastodon-openshift/pkgs/container/mastodon-openshift%2Fmastodon).

## Image Maintenance

The image is automatically rebuilt once a new upstream Mastodon image gets available.
Thanks to `renovate.json` and the GitHub Action pipeline.

## Helm Values

Here is an example for the [upstream Chart](https://github.com/mastodon/mastodon/tree/main/chart) which works on OpenShift.
It's neither optimized nor perfect, but it works:

```yaml
replicaCount: 1

image:
  repository: ghcr.io/appuio/mastodon-openshift/mastodon
  tag: v4.0.2
  pullPolicy: IfNotPresent

mastodon:
  createAdmin:
    enabled: true
    username: theadmin
    email: admin@mastodon.local
  local_domain: mastodon.local
  persistence:
    assets:
      accessMode: ReadWriteMany
      storageClassName: cephfs-fspool-cluster
      resources:
        requests:
          storage: 10Gi
    system:
      accessMode: ReadWriteMany
      storageClassName: cephfs-fspool-cluster
      resources:
        requests:
          storage: 10Gi
  secrets:
    secret_key_base: CHANGEME
    otp_secret: CHANGEME
    vapid:
      private_key: CHANGEME
      public_key: CHANGEME
  smtp:
    auth_method: plain
    delivery_method: smtp
    domain: mastodon.local
    enable_starttls: 'auto'
    from_address: notifications@mastodon.local
    openssl_verify_mode: peer
    port: 587
    reply_to: admin@mastodon.local
    server: CHANGEME
    tls: false
    login: CHANGEME
    password: CHANGEME

ingress:
  enabled: true
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-production
  hosts:
    - host: mastodon.local
      paths:
        - path: '/'
  tls:
    - secretName: ingress-tls
      hosts:
        - mastodon.local

podSecurityContext: null
securityContext: null

## Services
elasticsearch:
  enabled: false

postgresql:
  enabled: true
  auth:
    database: mastodon_production
    username: mastodon
    password: CHANGEME
  primary:
    podSecurityContext:
      enabled: false
    containerSecurityContext:
      enabled: false

redis:
  password: CHANGEME
  architecture: standalone
  master:
    persistence:
      size: "1Gi"
    podSecurityContext:
      enabled: false
    containerSecurityContext:
      enabled: false
```
