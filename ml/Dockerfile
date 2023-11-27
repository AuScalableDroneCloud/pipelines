ARG BASE_CONTAINER=ghcr.io/auscalabledronecloud/pipeline-gpu
FROM $BASE_CONTAINER

LABEL maintainer "ASDC <owen.kaluza@monash.edu>"

USER ${NB_UID}

ARG TORCH_CUDA=118

# Install torch 
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu${TORCH_CUDA}

