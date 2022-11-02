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
        jupyterlab-system-monitor \
        python-dotenv \
        tqdm \
        jupyter-server-proxy \
        pillow \
        qrcode \
        git+https://github.com/AuScalableDroneCloud/asdc_python \
        pyodm==1.5.9 \
        rasterio \
        rasterstats \
        GEOS \
        ODMax \
        nbgitpuller && \
        fix-permissions "${CONDA_DIR}" && \
        fix-permissions "/home/${NB_USER}"

# Hack odk2odm to work with our tokens
RUN git clone https://github.com/localdevices/odk2odm.git && \
    sed -i 's/JWT {}/Bearer {}/g' odk2odm/odk2odm/odm_requests.py && \
    pip install  --quiet --no-cache-dir ./odk2odm

#Install conda packages
RUN conda install -y -c conda-forge cartopy libopencv opencv py-opencv gdal

#Fix for gdal error
ENV PROJ_LIB "/opt/conda/share/proj"

#Add to python path for our api modules
ENV PYTHONPATH "${PYTHONPATH}:/home/jovyan/asdc"

#Fix permissions
USER root
RUN chmod +x /usr/local/bin/start*.sh
USER ${NB_UID}

