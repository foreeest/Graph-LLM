# 指定基础镜像，使用 CUDA 11.8 和 Ubuntu 22.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3.10-dev \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置 python3.10 为默认 python
RUN ln -s /usr/bin/python3.10 /usr/bin/python

# 升级 pip
RUN python -m pip install --upgrade pip

# 设置工作目录
WORKDIR /app

# 复制 requirements.txt 并安装依赖
COPY requirements.txt .

# 安装 PyTorch 和相关的 PyG 组件
# 注意：由于 requirements.txt 中已经指定了 +pt20cu118，我们需要指定对应的 whl 路径
RUN pip install torch==2.0.1+cu118 torchvision==0.15.2+cu118 --extra-index-url https://download.pytorch.org/whl/cu118

# 安装其他依赖
# 过滤掉已经手动安装的 torch 和 torchvision，或者直接运行以免版本冲突
RUN pip install --no-cache-dir -r requirements.txt -f https://data.pyg.org/whl/torch-2.0.0+cu118.html

# 复制项目代码
COPY . .

# 暴露端口（如果需要的话，比如启动 tensorboard 或 web 服务）
# EXPOSE 6006

# 默认启动命令
CMD ["bash"]
