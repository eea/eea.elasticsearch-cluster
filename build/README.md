# Build and push docker images manually (Optional)

__NOTE: [Docker Automated Builds](http://docs.docker.com/docker-hub/builds/) are already configured 
and available at [eeacms docker repository](https://registry.hub.docker.com/repos/eeacms/), 
therefore no need to use the procedure below unless really necessary for testing and development 
or [when building order is important](https://groups.google.com/forum/#!topic/docker-user/bkZXVezrWGs).__

This folder contains scripts to build and push images manually 
to [Docker Hub Registry](https://registry.hub.docker.com/) in the 
[eeacms docker repository](https://registry.hub.docker.com/repos/eeacms/).

## First try to build the images locally

  1. make sure IMAGE_PREFIX="" (see build_all_elasticsearch.sh)
  2. edit all Dockerfiles and remove the eeacms from the FROM image instruction, e.g. leave only FROM elasticsearch:0.90.13
  3. build_all_elasticsearch.sh

Now all images are built and stored locally. You will see the three images 
(elasticsearch-[base,master,worker]) listed if you run `sudo docker images` for example:

<pre>
$ sudo docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
elasticsearch-master        0.90.13             8752c19c8871        4 hours ago         771.7 MB
elasticsearch-worker        0.90.13             6e1adad1da00        4 hours ago         783.4 MB
<none>                      <none>              b4ccce726b16        4 hours ago         783.4 MB
elasticsearch-base          0.90.13             a49d4d5715b5        4 hours ago         783.4 MB
dockerfile/java             oracle-java7        6191d06ead72        2 days ago          717.4 MB
amplab/dnsmasq-precise      latest              d9cdba2ae123        10 months ago       205.8 MB
</pre>

## Secondly re-build,tag and push to Docker Hub Registry

Now you can build all again with right IMAGE_PREFIX to "eeacms" (1,2). 
After you run `build_all_elasticsearch.sh` (3) you can inspect again the images 
built via `sudo docker images` and after that you tag (4) and finally push (5) to the 
Docker Hub Registry:

  1. set IMAGE_PREFIX="eeacms/"
  2. re-edit all the Dockerfiles and put back the eeacms prefix as FROM eeacms/elasticsearch:0.90.13
  3. build_all_elasticsearch.sh
  4. tag_all.sh
  5. push_all.sh 

