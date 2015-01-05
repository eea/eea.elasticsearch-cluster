#
# EEA ElasticSearch Cluster Worker Dockerfile
#
# https://github.com/eea/eea.elasticsearch-cluster
#
 
# Pull base image.
FROM elasticsearch-base:0.90.13
MAINTAINER Antonio De Marinis <demarinis@eea.europa.eu>

ADD files /root/elasticsearch_worker_files
RUN chmod 700 /root/elasticsearch_worker_files/run_elasticsearch_worker.sh
CMD ["/root/elasticsearch_worker_files/run_elasticsearch_worker.sh"]
