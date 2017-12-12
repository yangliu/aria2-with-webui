FROM alpine:edge

MAINTAINER yangliu <i@yangliu.name>

ENV PUID=1024 PGID=1024

RUN apk update && \
	apk add --no-cache bash ca-certificates aria2 && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh && \
    chmod +x /conf-copy/on-complete.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 51024

ENTRYPOINT ["/conf-copy/start.sh"]
