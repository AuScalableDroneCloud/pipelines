# Start from a core-stack notebook, preferably matching the version of 
# jupyterhub we expect to deploy into.
FROM jupyter/minimal-notebook:hub-2.1.1

LABEL maintainer "ASDC <owen.kaluza@monash.edu>"

USER root

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.4 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451 brand=tesla,driver>=460,driver<461"
ENV NV_CUDA_CUDART_VERSION 11.4.108-1
ENV NV_CUDA_COMPAT_PACKAGE cuda-compat-11-4
ENV CUDA_VERSION 11.4.2

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 ca-certificates && \
    sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list

RUN apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
      cuda-cudart-11-4=${NV_CUDA_CUDART_VERSION} \
      ${NV_CUDA_COMPAT_PACKAGE} \
      libgl1 \
      exiftool \
      build-essential \
      cmake \
      git \
      libegl1-mesa-dev \
      libwayland-dev \
      libx11-xcb-dev \
      libxkbcommon-dev \
      libxrandr-dev \
      python3 \
      python3-distutils \
      wget && \
      rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

COPY NGC-DL-CONTAINER-LICENSE /

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

ENV NVIDIA_DRIVER_CAPABILITIES compute,graphics,utility

COPY nvidia_icd.json /etc/vulkan/icd.d/nvidia_icd.json

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

USER ${NB_UID}

# Install python packages
RUN pip install --quiet --no-cache-dir \
        matplotlib \
        scipy \
        ipywidgets \
        ipyfilechooser \
        voila \
        jupytext \
        jupyter-http-over-ws \
        jupyter-resource-usage \
        git+https://github.com/AuScalableDroneCloud/jupyter_oauth2.git@asdc \
        python-dotenv \
        pyodm==1.5.9 \
        rasterio \
        rasterstats \
        nbgitpuller && \
        fix-permissions "${CONDA_DIR}" && \
        fix-permissions "/home/${NB_USER}"

#Install conda packages
RUN conda install -y -c conda-forge cartopy libopencv opencv py-opencv

#Try this to fix numpy error
RUN rm -rf /opt/conda/lib/python3.9/site-packages/numpy-1.22.3.dist-info

#Add to python path for our api modules
ENV PYTHONPATH "${PYTHONPATH}:/home/jovyan/asdc"

