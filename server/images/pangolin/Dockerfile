FROM docker.io/fosrl/pangolin:postgresql-1.8.0
RUN apk add --no-cache envsubst
COPY ./config.yml.tmpl /app/config/config.yml.tmpl
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.override.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.override.sh"]
CMD ["npm", "run", "start:pg"]
