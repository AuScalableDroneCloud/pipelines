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
        matplotlib \
        scipy \
        ipywidgets \
        ipyfilechooser \
        voila \
        jupytext \
        jupyter-http-over-ws \
        jupyter-resource-usage \
        git+https://github.com/AuScalableDroneCloud/jupyter_oauth2.git \
        python-dotenv \
        pyodm==1.5.9 \
        nbgitpuller && \
        fix-permissions "${CONDA_DIR}" && \
        fix-permissions "/home/${NB_USER}"

#Install conda packages
RUN conda install -y -c conda-forge cartopy libopencv opencv py-opencv

#Try this to fix numpy error
RUN rm -rf /opt/conda/lib/python3.9/site-packages/numpy-1.22.3.dist-info

#Add to python path for our api modules
ENV PYTHONPATH "${PYTHONPATH}:/home/jovyan/asdc"

