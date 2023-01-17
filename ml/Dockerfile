ARG BASE_CONTAINER=ghcr.io/auscalabledronecloud/pipeline-gpu
FROM $BASE_CONTAINER

LABEL maintainer "ASDC <owen.kaluza@monash.edu>"

# Vulkan testing, disabled for now
#RUN apt-get update && \
#    apt-get install -y python3-pip curl libglu1-mesa libgl1-mesa-glx libxi6 libsm6 libfontconfig libxrender1 libqt5x11extras5 && \
#    curl https://packages.lunarg.com/lunarg-signing-key-pub.asc | apt-key add - && \
#    curl -L http://packages.lunarg.com/vulkan/lunarg-vulkan-focal.list --output /etc/apt/sources.list.d/lunarg-vulkan-focal.list && \
#    apt-get update && \
#    apt-get install -y vulkan-sdk && \
#    rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

#ARG TORCH_CUDA=117
ARG TORCH_CUDA=11.7

USER root
# Install torch 
#RUN pip install --quiet --no-cache-dir --pre \
#        torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cu${TORCH_CUDA}

RUN mamba install -y pytorch torchvision torchaudio pytorch-cuda=${TORCH_CUDA} -c pytorch -c nvidia
