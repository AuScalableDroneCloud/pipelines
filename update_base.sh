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

#https://hub.docker.com/r/nvidia/cuda/
#These require a newer driver
#NOTE: pytorch requires 11.6 for stable, 11.7 for nightly currently, only 11.7 has 22.04 build
#NOTE: cudann8 vs bare 11.8.0-runtime-ubuntu22.04 is ~500GB larger
#CUDA_IMAGE=cuda:11.8.0-cudnn8-runtime-ubuntu22.04
#CUDA_IMAGE=cuda:11.7.0-cudnn8-runtime-ubuntu22.04
CUDA_IMAGE=cuda:11.2.2-cudnn8-runtime-ubuntu20.04

sed -i "s/ROOT_CONTAINER=nvidia.*/ROOT_CONTAINER=nvidia\/${CUDA_IMAGE}/g" .github/workflows/build-images.yaml

docker build -t base-notebook --build-arg ROOT_CONTAINER=nvidia/${CUDA_IMAGE} -f Dockerfile .
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

cd ../experiments
docker build -t pipeline-exp --build-arg BASE_CONTAINER=pipeline-base -f Dockerfile .

#TEST
#docker run -p 8888:8888 pipeline-exp

