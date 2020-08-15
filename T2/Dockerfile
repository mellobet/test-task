FROM ubuntu:16.04

ENV NGINX_VER 1.10.3-0ubuntu0.16.04.5
# ENV KEEPALV_VER xxxxxx

RUN apt-get update && \
    apt-get install -y \
        nginx=${NGINX_VER} \
        keepalived && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

COPY states.sh /states.sh
RUN chmod +x /states.sh

EXPOSE 80

ENTRYPOINT [ "entrypoint.sh" ]
