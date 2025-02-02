# 使用 Ubuntu 18.04 作为基础镜像
FROM ubuntu:18.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必需的软件包
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 添加 NVIDIA 的 GPG 密钥
RUN wget -qO- https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add -

# 添加 CUDA 的 repository
RUN echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list

# 更新包列表并安装 CUDA 10.2 工具包
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-10-2 \
    && rm -rf /var/lib/apt/lists/*

# 设置环境变量以确保 CUDA 程序可以找到库
ENV PATH=/usr/local/cuda-10.2/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# 验证 CUDA 安装
RUN nvidia-smi

CMD ["bash"]
