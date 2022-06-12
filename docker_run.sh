#!/usr/bin/env bash
docker run -it --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 6006:6006 -p 8888:8888 -v $(pwd):/root/espnet/egs2/finetune seastar105/jets-finetune bash
