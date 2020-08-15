FROM ubuntu:16.04

ENV NGINX_VER 1.10.3-0ubuntu0.16.04.5
ENV KEEPALIVE_VER 1:1.2.24-1ubuntu0.16.04.2

RUN apt-get update && \
    apt-get install -y \
        nginx=${NGINX_VER} \
        keepalived=${KEEPALIVE_VER} && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

COPY states.sh /states.sh
RUN chmod +x /states.sh

EXPOSE 80

#ENTRYPOINT [ "/usr/sbin/keepalived" ]
#CMD [ "--log-detail", "--use-file", "/etc/keepalived/keepalived.conf", "--dont-fork", "--log-console" ]

ENTRYPOINT [ "entrypoint.sh" ]
