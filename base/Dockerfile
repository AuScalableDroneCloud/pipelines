# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM jupyter/minimal-notebook:hub-1.4.2

# Install nbgitpuller and pyodm
RUN pip install --quiet --no-cache-dir 'pyodm==1.5.6' 'nbgitpuller' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
RUN /opt/conda/bin/conda install jupyter -y --quiet && jupyter serverextension enable --sys-prefix --py jupyter_server_proxy
