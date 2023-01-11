ARG BASE_CONTAINER=jupyter/minimal-notebook:hub-3.0.0
FROM $BASE_CONTAINER

# Install library deps for pip packages
# https://odmax.readthedocs.io/en/latest/installation.html
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    libimage-exiftool-perl libgeos-dev libgdal-dev gdal-bin build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install python packages
# (We may want to build requirements in a builder image and use wheels to install in final image,
#  see: https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/main/images/singleuser-sample/Dockerfile)
#(NOTE: opencv is CPU only - will need to build our own to use GPU)
COPY --chown=jovyan:users requirements.txt requirements.txt
#Ensure numpy is installed first for gdal
RUN export GDAL_VERSION=$(gdal-config --version) && \
    source activate base && \
    pip install --no-cache-dir numpy && \
    pip install --no-cache-dir -r requirements.txt

#https://github.com/Anaconda-Platform/nb_conda_kernels
RUN conda install --yes -n base nb_conda_kernels

# Create a python 3.8 environment and repeat package installations
RUN conda create --yes -n Python3.8 python=3.8 && \
    source activate Python3.8 && \
    export GDAL_VERSION=$(gdal-config --version) && \
    pip install --no-cache-dir numpy && \
    pip install --no-cache-dir -r requirements.txt && \
    conda deactivate && \
    rm requirements.txt

ENV CONDA_DEFAULT_ENV base

COPY start-notebook-asdc.sh /usr/local/bin/

#Fix permissions
USER root
RUN chmod +x /usr/local/bin/start*.sh
USER ${NB_UID}

CMD ["start-notebook-asdc.sh"]

