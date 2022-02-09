# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM jupyter/minimal-notebook:hub-2.1.1

# Install nbgitpuller and pyodm
RUN pip install --quiet --no-cache-dir 'pyodm==1.5.9' 'nbgitpuller' 'git+https://github.com/AuScalableDroneCloud/jupyter_oauth2.git' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install api module until in own repo with setup.py
COPY asdc.py /opt/conda/lib/python3.9/site-packages

