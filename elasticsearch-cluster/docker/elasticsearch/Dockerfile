FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.2
ENV VERSION 5.4.2
USER root
ADD elasticsearch.yml config/
ADD run.sh run.sh
RUN chown elasticsearch config/elasticsearch.yml \
    && chown elasticsearch logs \
    && wget -qO /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.10/gosu-i386 \
    && chmod +x /usr/local/bin/gosu && gosu nobody true \
    && chmod +x run.sh
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:${VERSION} --verbose
CMD ["sh", "run.sh"]
