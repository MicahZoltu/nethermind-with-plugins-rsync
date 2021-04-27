ARG NETHERMIND_VERSION
ARG PUSH_VERSION
ARG MULTICALL_VERSION
ARG THIS_VERSION

FROM ghcr.io/micahzoltu/nethermind-with-plugins:${NETHERMIND_VERSION}-${PUSH_VERSION}-${MULTICALL_VERSION}

ENV NETHERMIND_SYNC_SSH_KEY_PATH="/run/secrets/rsync_ssh_key"
ENV NETHERMIND_SYNC_SERVER=""
ENV NETHERMIND_SYNC_PORT="2828"
ENV NETHERMIND_SYNC_SNAP_OVERRIDE=""
ENV NETHERMIND_SYNC_FORCE="false"

RUN apt-get install -y rsync openssh-client

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
