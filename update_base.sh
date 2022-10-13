#!/bin/bash
mkdir -p base-notebook
cd base-notebook
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/LICENSE.md -O LICENSE_Dockerfile.md
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/Dockerfile -O Dockerfile
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/fix-permissions -O fix-permissions
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/initial-condarc -O initial-condarc
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/jupyter_server_config.py -O jupyter_server_config.py
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/start-notebook.sh -O start-notebook.sh
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/start-singleuser.sh -O start-singleuser.sh
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/base-notebook/start.sh -O start.sh

docker build -t base-notebook --build-arg ROOT_CONTAINER=nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 -f Dockerfile .
cd ..

mkdir -p minimal-notebook
cd minimal-notebook
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/minimal-notebook/Dockerfile -O Dockerfile
wget https://raw.githubusercontent.com/jupyter/docker-stacks/main/minimal-notebook/Rprofile.site -O Rprofile.site

docker build -t minimal-notebook --build-arg BASE_CONTAINER=base-notebook -f Dockerfile .
cd ..

cd base
docker build -t pipeline-base --build-arg BASE_CONTAINER=minimal-notebook -f Dockerfile .

#TEST
#docker run -p 8888:8888 pipeline-base

