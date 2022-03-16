# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM jupyter/minimal-notebook:hub-2.1.1

USER root

# Install system packages
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        libgl1 \
        exiftool

USER ${NB_UID}

# Install python packages
RUN pip install --quiet --no-cache-dir \
        nbgitpuller && \
        fix-permissions "${CONDA_DIR}" && \
        fix-permissions "/home/${NB_USER}"

#Add to python path for our api modules
ENV PYTHONPATH "${PYTHONPATH}:/home/jovyan/asdc"

