#!/bin/bash
#Get the jupyter/docker-stacks files
SRC=https://raw.githubusercontent.com/jupyter/docker-stacks/main/
#SRC=https://raw.githubusercontent.com/AuScalableDroneCloud/docker-stacks/main/

rm -rf docker-stacks-foundation
mkdir -p docker-stacks-foundation

wget ${SRC}docker-stacks-foundation/Dockerfile -O docker-stacks-foundation/Dockerfile
wget ${SRC}docker-stacks-foundation/fix-permissions -O docker-stacks-foundation/fix-permissions
wget ${SRC}docker-stacks-foundation/initial-condarc -O docker-stacks-foundation/initial-condarc
wget ${SRC}docker-stacks-foundation/start.sh -O docker-stacks-foundation/start.sh

rm -rf base-notebook
mkdir -p base-notebook
wget ${SRC}base-notebook/Dockerfile -O base-notebook/Dockerfile
wget ${SRC}base-notebook/docker_healthcheck.py -O base-notebook/docker_healthcheck.py
wget ${SRC}base-notebook/jupyter_server_config.py -O base-notebook/jupyter_server_config.py
wget ${SRC}base-notebook/start-notebook.sh -O base-notebook/start-notebook.sh
wget ${SRC}base-notebook/start-singleuser.sh -O base-notebook/start-singleuser.sh

rm -rf minimal-notebook
mkdir -p minimal-notebook
wget ${SRC}minimal-notebook/Dockerfile -O minimal-notebook/Dockerfile
wget ${SRC}minimal-notebook/Rprofile.site -O minimal-notebook/Rprofile.site


