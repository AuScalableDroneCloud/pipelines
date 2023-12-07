#!/bin/bash
#Get the jupyter/docker-stacks files
REPO=https://github.com/jupyter/docker-stacks/
BRANCH=main
SRC=https://raw.githubusercontent.com/jupyter/docker-stacks/main/images/
#SRC=https://raw.githubusercontent.com/AuScalableDroneCloud/docker-stacks/main/

rm -rf docker-stacks-${BRANCH}
wget ${REPO}/archive/refs/heads/${BRANCH}.zip
unzip ${BRANCH}.zip
rm ${BRANCH}.zip
