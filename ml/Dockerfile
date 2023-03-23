ARG BASE_CONTAINER=ghcr.io/auscalabledronecloud/pipeline-gpu
FROM $BASE_CONTAINER

LABEL maintainer "ASDC <owen.kaluza@monash.edu>"

USER ${NB_UID}

ARG TORCH_CUDA=117

# Install torch 
RUN pip install --quiet --no-cache-dir --pre \
        torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cu${TORCH_CUDA}

