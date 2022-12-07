#!/bin/bash
./update_base.sh

#https://hub.docker.com/r/nvidia/cuda/
#These require a newer driver
#NOTE: pytorch requires 11.6 for stable, 11.7 for nightly currently, only 11.7 has 22.04 build
#NOTE: cudann8 vs bare 11.8.0-runtime-ubuntu22.04 is ~500GB larger
#CUDA_IMAGE=cuda:11.8.0-cudnn8-runtime-ubuntu22.04
CUDA_IMAGE=cuda:11.7.0-cudnn8-runtime-ubuntu22.04
#CUDA_IMAGE=cuda:11.2.2-cudnn8-runtime-ubuntu20.04

sed -i "s/ROOT_CONTAINER=nvidia.*/ROOT_CONTAINER=nvidia\/${CUDA_IMAGE}/g" .github/workflows/build-images.yaml

ROOT=nvidia/${CUDA_IMAGE}
#ROOT=ubuntu:20.04

cd docker-stacks-foundation
docker build -t docker-stacks-foundation --build-arg ROOT_CONTAINER=${ROOT} -f Dockerfile .
cd ..

cd base-notebook
docker build -t base-notebook --build-arg BASE_CONTAINER=docker-stacks-foundation -f Dockerfile .
cd ..

cd minimal-notebook
docker build -t minimal-notebook --build-arg BASE_CONTAINER=base-notebook -f Dockerfile .
cd ..

cd base
docker build -t pipeline-base --build-arg BASE_CONTAINER=minimal-notebook -f Dockerfile .

#TEST
#docker run -p 8888:8888 pipeline-base

#cd ../fd
#docker build -t pipeline-fd --build-arg BASE_CONTAINER=pipeline-base -f Dockerfile .

#TEST
#docker run -p 8888:8888 pipeline-exp
