FROM ghcr.io/auscalabledronecloud/pipeline-base

USER ${NB_UID}

# Hack odk2odm to work with our tokens
RUN git clone https://github.com/localdevices/odk2odm.git && \
    sed -i 's/JWT {}/Bearer {}/g' odk2odm/odk2odm/odm_requests.py && \
    pip install ./odk2odm

#Install conda packages
RUN conda install -y -c conda-forge cartopy

