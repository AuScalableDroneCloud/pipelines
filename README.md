# Pipeline environments for ASDC

Dockerfiles to build ASDC pipelines

NOTE: Pipelines are now separately defined rather than having a docker image exclusive to each pipeline

This repository builds the three core images available to use with ASDC pipelines:

- base : the base image, cpu only
- gpu : gpu support added
- ml : added ml libraries to the gpu image

The images are based on the jupyter docker-stacks images

To build the GPU images, we replace the Ubuntu:xx:yy image with a corresponding NVidia cuda image


