ARG BASE_CONTAINER=quay.io/jupyter/minimal-notebook:2023-11-21
FROM $BASE_CONTAINER
ARG GPU=false

#Fix permissions
USER root
RUN chmod +x /usr/local/bin/start*.sh

# Install library deps for pip packages
# https://odmax.readthedocs.io/en/latest/installation.html
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    libimage-exiftool-perl libgeos-dev libgdal-dev gdal-bin build-essential rclone git
USER ${NB_UID}

# Install python packages
# (We may want to build requirements in a builder image and use wheels to install in final image,
#  see: https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/main/images/singleuser-sample/Dockerfile)
#(NOTE: opencv is CPU only - will need to build our own to use GPU)
COPY --chown=jovyan:users environment.yml environment.yml

#Ensure numpy is installed first for gdal
RUN export GDAL_VERSION=$(gdal-config --version) && \
    source activate base && \
    sed -i "s/GDAL_VERSION/$GDAL_VERSION/g" environment.yml && \
    mamba env update --file environment.yml 
#    pip install --no-cache-dir numpy && \

# Create a python 3.8 environment and repeat package installations
RUN conda create --yes -n Python3.8 python=3.8 && \
    mamba env update -n Python3.8 --file environment.yml

# Create a python 3.9 environment and repeat package installations
RUN conda create --yes -n Python3.9 python=3.9 && \
    mamba env update -n Python3.9 --file environment.yml

ENV CONDA_DEFAULT_ENV base

# Install Pyenv
RUN curl https://pyenv.run | bash
ENV PATH="/home/${NB_USER}/.pyenv/bin:$PATH"
RUN echo 'eval "$(pyenv init --path)"' >> /home/${NB_USER}/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> /home/${NB_USER}/.bashrc
