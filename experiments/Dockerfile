# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM ghcr.io/auscalabledronecloud/pipeline-base

#Vis experiments
USER ${NB_UID}

RUN pip install --yes 'lavavu-osmesa' && mamba install --quiet --yes \
    'jupyter-server-proxy' && \
    jupyter labextension install jupyterlab-server-proxy

