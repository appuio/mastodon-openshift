FROM docker.io/tootsuite/mastodon:v4.1.5

USER root

RUN chgrp -R 0 /opt/mastodon && \
    chmod -R g+rwX /opt/mastodon

USER mastodon
