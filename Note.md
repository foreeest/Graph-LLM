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
