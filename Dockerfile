FROM alpine

LABEL maintainer="jeanpul <fabien.pelisson@codeffekt.com>"

ARG build_date
LABEL image.date=${build_date}

RUN apk --no-cache add screen docker openssl openssh-client apache2-utils
RUN apk --no-cache add py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
RUN pip install docker-compose
COPY docker-tunnel /usr/bin/docker-tunnel

RUN chmod +x /usr/bin/docker-tunnel

