FROM ghcr.io/auscalabledronecloud/pipeline-base

USER root
#################################################################################################
# https://gitlab.com/nvidia/container-images/vulkan/-/blob/master/docker/Dockerfile.ubuntu18.04 #
#################################################################################################

# Copyright (c) 2020, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG CUDA_VERSION
#FROM ubuntu:18.04 as vulkan-khronos
#FROM ghcr.io/auscalabledronecloud/pipeline-base as base

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    git \
    libegl1-mesa-dev \
    libwayland-dev \
    libx11-xcb-dev \
    libxkbcommon-dev \
    libxrandr-dev \
    python3 \
    python3-distutils \
    wget && \
    rm -rf /var/lib/apt/lists/*

#ARG VULKAN_VERSION 
#ENV VULKAN_VERSION v1.1.121

# Download and compile vulkan components
#RUN ln -s /usr/bin/python3 /usr/bin/python && \
#    git clone https://github.com/KhronosGroup/Vulkan-ValidationLayers.git /opt/vulkan && \
#    cd /opt/vulkan && git checkout "${VULKAN_VERSION}" && \
#    mkdir build && cd build && ../scripts/update_deps.py && \
#    cmake -C helper.cmake -DCMAKE_BUILD_TYPE=Release .. && \
#    cmake --build . && make install && ldconfig && \
#    mkdir -p /usr/local/lib && cp -a Vulkan-Loader/build/install/lib/* /usr/local/lib && \
#    mkdir -p /usr/local/include/vulkan && cp -r Vulkan-Headers/build/install/include/vulkan/* /usr/local/include/vulkan && \
#    mkdir -p /usr/local/share/vulkan/registry && \
#    cp -r Vulkan-Headers/build/install/share/vulkan/registry/* /usr/local/share/vulkan/registry && \
#    rm -rf /opt/vulkan

#FROM nvidia/cudagl:${CUDA_VERSION}-base-ubuntu18.04
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#https://gitlab.com/nvidia/container-images/cuda/blob/master/dist/11.4.2/ubuntu2004/base/Dockerfile
#FROM ubuntu:20.04 as base

ENV NVARCH x86_64
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.4 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451 brand=tesla,driver>=460,driver<461"
ENV NV_CUDA_CUDART_VERSION 11.4.108-1
ENV NV_CUDA_COMPAT_PACKAGE cuda-compat-11-4

LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH}/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH} /" > /etc/apt/sources.list.d/cuda.list && \
    if [ ! -z ${NV_ML_REPO_ENABLED} ]; then echo "deb ${NV_ML_REPO_URL} /" > /etc/apt/sources.list.d/nvidia-ml.list; fi && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 11.4.2

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-11-4=${NV_CUDA_CUDART_VERSION} \
    ${NV_CUDA_COMPAT_PACKAGE} \
    && ln -s cuda-11.4 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

COPY NGC-DL-CONTAINER-LICENSE /

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ENV NVIDIA_DRIVER_CAPABILITIES compute,graphics,utility

RUN apt-get update && apt-get install -y --no-install-recommends \
    libx11-xcb-dev \
    libxkbcommon-dev \
    libwayland-dev \
    libxrandr-dev \
    libegl1-mesa-dev && \
    rm -rf /var/lib/apt/lists/*

#COPY --from=base /usr/local/bin /usr/local/bin
#COPY --from=base /usr/local/lib /usr/local/lib
#COPY --from=base /usr/local/include/vulkan /usr/local/include/vulkan
#COPY --from=base /usr/local/share/vulkan /usr/local/share/vulkan

COPY nvidia_icd.json /etc/vulkan/icd.d/nvidia_icd.json

#################################################################################################

# Install pip for python3, mesa deb for metashape, nodejs
RUN apt-get update && \
    apt-get install -y python3-pip curl libglu1-mesa libgl1-mesa-glx libxi6 libsm6 libfontconfig libxrender1 libqt5x11extras5 && \
    curl https://packages.lunarg.com/lunarg-signing-key-pub.asc | apt-key add - && \
    curl -L http://packages.lunarg.com/vulkan/lunarg-vulkan-focal.list --output /etc/apt/sources.list.d/lunarg-vulkan-focal.list && \
    apt-get update && \
    apt-get install -y vulkan-sdk && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Hack odk2odm to work with our tokens
RUN git clone https://github.com/localdevices/odk2odm.git && \
    sed -i 's/JWT {}/Bearer {}/g' odk2odm/odk2odm/odm_requests.py && \
    pip install ./odk2odm

# Root painter - AI testing
RUN git clone https://github.com/Abe404/root_painter.git && \
    cd root_painter/trainer && \
    pip install -r requirements.txt

