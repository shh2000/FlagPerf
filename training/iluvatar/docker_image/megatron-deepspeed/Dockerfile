FROM ubuntu:20.04

# copy /etc/apt/sources.list . or choose an available one if encountering a problem with the mirror source
# ADD sources.list /etc/apt/

RUN /bin/bash -c "source /root/.bashrc"

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH /root/miniconda/bin:$PATH

RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y --fix-missing \
     apt-utils \
     sudo \
     openssh-server \
     vim \
     git \
     curl \
     wget \
     tree \
     perl \
     kmod \
     make \
     pciutils \
     build-essential \
     python3.8-dev \
     python3-pip \
     libjpeg-dev \
     zlib1g-dev \
     unzip \
     cmake \
     bzip2 \
     cabextract \
     iputils-ping \
     pbzip2 \
     pv \
     numactl \
     ninja-build \
     gcc-7 \
     g++-7 \
     libncursesw5
     

# Configure anaconda
RUN wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh && \
    bash ./Miniconda3-py38_4.10.3-Linux-x86_64.sh -b -p /root/miniconda && \
    /root/miniconda/bin/conda clean -tipsy && \
    ln -s /root/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /root/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    conda config --set always_yes yes --set changeps1 no && \
    echo 'LD_LIBRARY_PATH="/usr/local/corex/lib:${LD_LIBRARY_PATH}"' >> ~/.bashrc && \
    echo 'PATH="/usr/local/corex/bin:${PATH}"' >> ~/.bashrc 


RUN /bin/bash -c "apt-get install -y linux-headers-`uname -r`"

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10 --slave /usr/bin/g++ g++ /usr/bin/g++-7

RUN /bin/bash -c "pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple"

# iluvatar megatron-deepspeed 
COPY megatron-deepspeed /workspace/megatron-deepspeed
COPY .triton /root/.triton

ENV LD_LIBRARY_PATH="/usr/local/corex/lib:${LD_LIBRARY_PATH}"
ENV PATH="/usr/local/corex/bin:${PATH}"
ENV NVCC_ARGUMENTS="-U__CUDA_NO_HALF_OPERATORS__ -U__CUDA_NO_HALF_CONVERSIONS__ -ftemplate-depth=1024"

