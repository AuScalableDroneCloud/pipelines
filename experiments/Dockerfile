# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM ghcr.io/auscalabledronecloud/pipeline-base

#Vis experiments
USER ${NB_UID}

# Install python packages
RUN pip install --quiet --no-cache-dir \
        GEOS \
        ODMax \
        python-dotenv \
        lavavu-osmesa

# Hack odk2odm to work with our tokens
RUN git clone https://github.com/localdevices/odk2odm.git && \
    sed -i 's/JWT {}/Bearer {}/g' odk2odm/odk2odm/odm_requests.py && \
    pip install ./odk2odm

#Install conda packages
RUN conda install -y -c conda-forge cartopy

