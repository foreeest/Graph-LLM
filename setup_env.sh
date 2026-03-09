#!/bin/bash
# 自动适配 CUDA 12.6 和 PyTorch 2.7 的环境安装脚本

echo "Starting environment setup for CUDA 12.6 / Python 3.10..."

# 1. 基础依赖
pip install -r requirements.txt

# 2. 安装 PyG 核心组件
echo "Installing PyG components for CUDA 12.x..."

# 方案 A: 尝试使用最新的 cu124 官方编译版本 (通常兼容 CUDA 12.6)
# 注意：由于 torch 2.7 是实验版本，官方 data.pyg.org 可能没有匹配版本
# 这里尝试使用最接近的稳定版本源
URL="https://data.pyg.org/whl/torch-2.4.0+cu124.html"

echo "Attempting installation from PyG wheel index: $URL"
pip install torch-scatter torch-sparse torch-cluster torch-spline-conv -f $URL || {
    echo "Warning: Pre-built wheels failed. Attempting standard installation (may take time to compile)..."
    # 方案 B: 让 pip 自行编译 (需要本地有 CUDA toolkit 和编译器)
    pip install torch-scatter torch-sparse torch-cluster torch-spline-conv
}

echo "Environment setup complete!"
echo "Please run 'python verify_env.py' to check the status."
