FROM ghcr.io/auscalabledronecloud/pipeline-base

USER ${NB_UID}

# Install python packages
RUN pip install --quiet --no-cache-dir \
        opencv-python \
        PyCoShREM

#Install conda packages
RUN conda install -y -c conda-forge gdal

# Make sure we have the latest fracture detection code
#(now in pipelines-jupyter)

