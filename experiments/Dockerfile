ARG BASE_CONTAINER=ghcr.io/auscalabledronecloud/pipeline-base
FROM $BASE_CONTAINER

USER root

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

# Hack odk2odm to work with our tokens
RUN git clone https://github.com/localdevices/odk2odm.git && \
    sed -i 's/JWT {}/Bearer {}/g' odk2odm/odk2odm/odm_requests.py && \
    pip install  --quiet --no-cache-dir ./odk2odm

# Install torch etc and additional packages for ODMax
RUN pip install --quiet --no-cache-dir \
        torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116 \
        GEOS \
        ODMax

