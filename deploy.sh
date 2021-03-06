#!/bin/bash

eval "$(ssh-agent -s)" &&
ssh-add -k ~/.ssh/id_rsa &&
cd ~/travis2/tukulsa-backend
git pull
mkdir storage && cd storage && mkdir log

source ~/.profile
echo "$DOCKERHUB_PASS" | docker login --username $DOCKERHUB_USER --password-stdin
docker stop tukulsaBE
docker rm tukulsaBE
docker rmi daffa99/containerd:BE2
docker run -d --name tukulsaBE -p 5000:5000 daffa99/containerd:BE2
