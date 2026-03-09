## build

```shell
docker build -t graph-llm .
```

## run

### use docker-compose
```shell
docker-compose up -d
```

### use docker cli (without docker-compose)
```shell
docker run --gpus all \
  -itd \
  --name graph-llm-container \
  -v $(pwd):/app \
  -v $(pwd)/LLaMA-7B-2:/app/LLaMA-7B-2 \
  -v $(pwd)/Llama-2-7b-hf:/app/Llama-2-7b-hf \
  -v $(pwd)/dataset:/app/dataset \
  -e CUDA_VISIBLE_DEVICES=0 \
  graph-llm
```

## Troubleshooting Build (Network/Large Files)

If you encounter timeouts downloading large files (like PyTorch 2.3GB):

### 1. Use a Proxy during Build
If you have a local proxy (e.g., v2ray/clash), use it during build:
```shell
docker build --build-arg http_proxy=http://<your-ip>:7890 --build-arg https_proxy=http://<your-ip>:7890 -t graph-llm .
```

### 2. Increase Timeout (Already in Dockerfile)
The `Dockerfile` now uses `--default-timeout=1000`. You can increase this further if needed.

### 3. Alternative: Use NVIDIA PyTorch Base Image
If the network is still too slow, you can change the `FROM` line in `Dockerfile` to use a pre-built image:
`FROM nvcr.io/nvidia/pytorch:23.05-py3`
This image already contains PyTorch 2.0.1 and might be faster to pull as a docker layer than downloading the wheel inside the container.
