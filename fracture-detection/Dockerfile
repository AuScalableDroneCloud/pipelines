FROM ghcr.io/auscalabledronecloud/pipeline-base

USER ${NB_UID}

#Install conda packages
RUN conda install -y -c conda-forge gdal

#Fix for gdal error
env PROJ_LIB "/opt/conda/share/proj"

# Make sure we have the latest fracture detection code
#(now in pipelines-jupyter)

# Install python packages
RUN pip install --quiet --no-cache-dir \
        PyCoShREM

