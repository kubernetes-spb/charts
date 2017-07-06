FROM alpine:3.4

ARG VERSION

RUN apk --update add python py-pip && \
    pip install elasticsearch-curator==$VERSION

COPY curator-cron /usr/local/bin
