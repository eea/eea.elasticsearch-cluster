#
# EEA ElasticSearch Cluster Base Dockerfile
# 
# https://github.com/eea/eea.elasticsearch-cluster
#
 
# Pull base image.
FROM dockerfile/java:oracle-java7
MAINTAINER Antonio De Marinis <demarinis@eea.europa.eu>

# Environment variables
ENV ES_HOME /elasticsearch
ENV ES_VERSION 0.90.13
ENV RDF_RIVER_VERSION 1.4.3
# Create elasticsearch user
ENV ES_USER elasticsearch
ENV ES_GROUP elasticsearch
 
# Install ElasticSearch.
RUN \
   cd /tmp && \
   wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz && \ 
   cd /tmp && \
   tar xvzf elasticsearch-$ES_VERSION.tar.gz && rm -f elasticsearch-$ES_VERSION.tar.gz && \
   mv /tmp/elasticsearch-$ES_VERSION $ES_HOME

# Install ES plugins
RUN /elasticsearch/bin/plugin -install mobz/elasticsearch-head && \
    /elasticsearch/bin/plugin --url https://github.com/eea/eea.elasticsearch.river.rdf/raw/master/target/releases/eea-rdf-river-plugin-$RDF_RIVER_VERSION.zip \
    --install eea-rdf-river-$RDF_RIVER_VERSION

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
# ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

# Add configuration files.
ADD files /root/elasticsearch_files
ADD files/elasticsearch.yml $ES_HOME/conf/elasticsearch.yml

RUN addgroup elasticsearch && \
    useradd elasticsearch -g elasticsearch && \
    chown -R elasticsearch.elasticsearch $ES_HOME
