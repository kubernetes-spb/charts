# docker build -t fulldive/rabbitmq-cluster:0.0.2 .
# docker push fulldive/rabbitmq-cluster:0.0.2
# https://github.com/rabbitmq/rabbitmq-autocluster
FROM rabbitmq:3.6.10-management-alpine

ADD autocluster-0.8.0.ez  /plugins
ADD rabbitmq_aws-0.8.0.ez  /plugins
RUN rabbitmq-plugins enable autocluster --offline
