FROM docker.io/library/alpine:3.22
RUN apk add --no-cache postgresql16-client bash
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
