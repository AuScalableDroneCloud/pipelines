ARG BASE_CONTAINER=jupyter/minimal-notebook:hub-3.0.0
FROM $BASE_CONTAINER

USER ${NB_UID}

# Install python packages
RUN pip install --quiet --no-cache-dir \
        matplotlib \
        scipy \
        ipywidgets \
        ipyfilechooser \
        ipylab \
        voila \
        jupytext \
        jupyter-http-over-ws \
        jupyter-resource-usage \
        python-dotenv \
        tqdm \
        jupyter-server-proxy \
        pillow \
        qrcode \
        git+https://github.com/AuScalableDroneCloud/asdc_python \
        pyodm==1.5.9 \
        rasterio \
        rasterstats \
        nbgitpuller && \
        fix-permissions "${CONDA_DIR}" && \
        fix-permissions "/home/${NB_USER}"

#Install conda packages
RUN conda install -y -c conda-forge cartopy libopencv opencv py-opencv

#Add to python path for our api modules
ENV PYTHONPATH "${PYTHONPATH}:/home/jovyan/asdc"

# Fix the cuda version check error
ENV NVIDIA_DISABLE_REQUIRE "1"

#Fix permissions
USER root
RUN chmod +x /usr/local/bin/start*.sh
USER ${NB_UID}

