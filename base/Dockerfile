# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM jupyter/minimal-notebook:hub-2.1.1

# Install system packages
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        exiftool

# Install python packages
RUN pip install --quiet --no-cache-dir \
        matplotlib \
        scipy \
        pyodm==1.5.9 \
        nbgitpuller \
        git+https://github.com/AuScalableDroneCloud/jupyter_oauth2.git && \
        fix-permissions "${CONDA_DIR}" && \
        fix-permissions "/home/${NB_USER}"

# Install api module until in own repo with setup.py
COPY asdc.py /opt/conda/lib/python3.9/site-packages

