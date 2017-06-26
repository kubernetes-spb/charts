FROM ubuntu:xenial
MAINTAINER Maxim Filatov <mf@evl.ms>

# System tools and upgrade
RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y curl wget bash-completion && \
    apt-get -y autoremove && \
    rm -fr /var/cache/apt/archives

# Install postgresql libs
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' > /etc/apt/sources.list.d/pgsql.list && \
    apt-get update && apt-get -y install libpq-dev && \
    rm -fr /var/cache/apt/archives

# Install sysbench
RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash && \
    apt-get -y install sysbench && \
    rm -fr /var/cache/apt/archives

RUN mkdir /workdir
