# EEA Elasticsearch Cluster dockerfiles

This repository containes Dockerfiles and scripts to build and deploy the EEA Elasticsearch cluster as Docker containers. 

It includes several useful elasticsearch plugins such as the [EEA RDF River plugin](https://github.com/eea/eea.elasticsearch.river.rdf) used to index data from RDF dumps and/or SPARQL endpoints.

__It makes it easier to develop, ship and run the EEA Elasticsearch cluster anywhere, leaving the host clean.__

## Requirements
All you need is [Docker installed](https://docs.docker.com/) on the host.

Tested on Ubuntu 14.04/14.10 and docker version 1.2.0. It should run on any OS capable of running Docker. For running Docker on Mac and Windows see [the docker docs](http://docs.docker.io).

## Deploy the Elasticsearch cluster

__Download the scripts__
<pre>
$ git clone https://github.com/eea/eea.elasticsearch-cluster.git
</pre>

<pre>
$ sudo ./deploy/deploy_elasticsearch.sh
usage: deploy/deploy_elasticsearch.sh -i &lt;image&gt; [-w &lt;#workers&gt;] [-v &lt;data_directory&gt;]

  image:    elasticsearch image from:
                 eeacms/elasticsearch:0.90.13
</pre>

__Example Deploy a cluster with 3 workers__
<pre>
$ NUMBER_OF_DATANODES=3
$ sudo deploy/deploy_elasticsearch.sh -i eeacms/elasticsearch:0.90.13 -w $NUMBER_OF_DATANODES
</pre>

Note that on the first call it may take a while for Docker to download the
various images from the docker repository.

This will (typically) result in the following setup:

<pre>
NAMESERVER                 10.1.0.3
ELASTICSEARCH MASTER       10.1.0.4
ELASTICSEARCH DATANODE     10.1.0.5
ELASTICSEARCH DATANODE     10.1.0.6
ELASTICSEARCH DATANODE     10.1.0.7
</pre>

When the deploy script is run it generates one container
for the master node, one container for each worker node (aka DATANODE) and one extra
container running a Dnsmasq DNS forwarder (aka NAMESERVER). The latter one can also be
used to resolve node names on the host.

Optionally one can set the number of workers (default: 2) and a data directory
which is a local path on the host that can be mounted on the master and
worker containers and will appear under /data. This is useful for having 
persistent elasticsearch index.


## Kill the Elasticsearch cluster

<pre>
$ sudo deploy/kill_all.sh elasticsearch
$ sudo deploy/kill_all.sh nameserver
</pre>

## After Elasticsearch cluster is killed, cleanup
<pre>
$ sudo docker rm `sudo docker ps -a -q`
$ sudo docker images | grep "&lt;none&gt;" | awk '{print $3}' | xargs sudo docker rmi
</pre>

## Build local images (optional)

If you prefer to build the images yourself (or intend to modify them) rather
than downloading them from the Docker repository, you can build
all Elasticsearch images in the correct order via the build script:

__Change file permissions__
<pre>    
$ chmod a+x build/build_all_elasticsearch.sh
$ chmod a+x elasticsearch-0.90.13/build
$ chmod a+x deploy/deploy_elasticsearch.sh
</pre>

__Build__
<pre>    
$ sudo build/build_all_elasticsearch.sh
</pre>

The script builds the images in an order that satisfies the chain of
dependencies:

elasticsearch-base -> elasticsearch-{master, worker}

You can always (re-)build single images by cd-ing into the image directory and doing

	$ . build

### Best practices for Dockerfiles and startup scripts

The following are just some comments that made the generation of the images easier. It
is not enforced in any way by Docker.

The images and startup scripts follow the following structure in order to reuse
as much as possible of the image they depend on. There are two types of images,
<em>base</em> images and <em>leaf</em> images. Leaf images, as the name suggests,
are images that are leafs in the dependency tree. For example, elasticsearch-master depends on elasticsearch-base as
its base image and is itself a leaf.

In addition to its Dockerfile, each image has a
	files/
subdirectory in its image directory that contains files (config files, data files) that will be copied
to the
	root/<em>image_name</em>_files
directory inside the image.

## Tips

### Name resolution on host

In order to resolve names (such as "master", "worker1", etc.) add the IP
of the nameserver container to the top of /etc/resolv.conf on the host.

### Maintaining local Docker image repository

After a while building and debugging images the local image repository gets
full of intermediate images that serve no real purpose other than
debugging a broken build. To remove these do

	$ sudo docker images | grep "&lt;none&gt;" | awk '{print $3}' | xargs sudo docker rmi

Also data from stopped containers tend to accumulate. In order to remove all container data (__only do when no containers are running__) do

	$ sudo docker rm `sudo docker ps -a -q`


### Credits
This repository was based on a fork from amplab / docker-scripts.
DNS and cluster setup are all credited to the great work of the amplab team.

## Copyright and license
The Initial Owner of the Original Code is European Environment Agency (EEA). All Rights Reserved.

The EEA ElasticSearch Cluster (the Original Code) is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
