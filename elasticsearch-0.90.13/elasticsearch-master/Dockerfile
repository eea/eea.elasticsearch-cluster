#
# EEA ElasticSearch Cluster Master Dockerfile
#
# https://github.com/eea/eea.elasticsearch-cluster
#
 
# Pull base image.
FROM eeacms/elasticsearch-base:0.90.13
MAINTAINER Antonio De Marinis <demarinis@eea.europa.eu>

ADD files /root/elasticsearch_master_files
RUN chmod 700 /root/elasticsearch_master_files/run_elasticsearch_master.sh
CMD ["/root/elasticsearch_master_files/run_elasticsearch_master.sh"]
