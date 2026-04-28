FROM alpine:3.19

ARG build_date
ARG version

LABEL maintainer="jeanpul <fabien.pelisson@codeffekt.com>"
LABEL org.opencontainers.image.title="docker-remote-tunnel"
LABEL org.opencontainers.image.description="Run remote Docker commands via an SSH tunnel"
LABEL org.opencontainers.image.source="https://github.com/jeanpul/docker-remote-tunnel"
LABEL org.opencontainers.image.version=${version}
LABEL org.opencontainers.image.created=${build_date}

RUN apk --no-cache add screen docker-cli docker-cli-compose openssl openssh-client apache2-utils

COPY docker-tunnel /usr/bin/docker-tunnel
RUN chmod +x /usr/bin/docker-tunnel

