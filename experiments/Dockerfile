# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM ghcr.io/auscalabledronecloud/pipeline-base

#Vis experiments
USER ${NB_UID}

RUN pip install --quiet --no-cache-dir 'jupyter-server-proxy' 'lavavu-osmesa'

RUN pip install --quiet --no-cache-dir git+https://github.com/AuScalableDroneCloud/jupyter_oauth2.git
