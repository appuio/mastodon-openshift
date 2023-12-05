FROM docker.io/tootsuite/mastodon:v4.2.3

USER root

RUN chgrp -R 0 /opt/mastodon && \
    chmod -R g+rwX /opt/mastodon

USER mastodon
