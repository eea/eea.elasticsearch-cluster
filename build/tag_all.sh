#!/bin/bash

if [[ "$USER" != "root" ]]; then
    echo "please run as: sudo $0"
    exit 1
fi

image_list=("elasticsearch-base:0.90.13" "elasticsearch-master:0.90.13" "elasticsearch-worker:0.90.13")

IMAGE_PREFIX="eeacms/"

# NOTE: the order matters but this is the right one
for i in ${image_list[@]}; do
	image=$(echo $i | awk -F ":" '{print $1}')
        echo docker tag ${IMAGE_PREFIX}${i} ${IMAGE_PREFIX}${image}:latest
	docker tag ${IMAGE_PREFIX}${i} ${IMAGE_PREFIX}${image}:latest
done
