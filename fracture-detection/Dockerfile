# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM jupyter/base-notebook:hub-1.4.1

# Install nbgitpuller
RUN pip install --quiet --no-cache-dir 'nbgitpuller' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Make sure we have the latest fracture detection code