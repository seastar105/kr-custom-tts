#!/usr/bin/env bash

# build image
docker build -t jets-finetune .
docker run -it --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 6006:6006 -p 8000:8000 -v $(pwd):/root/espnet/egs2/finetune jets-finetune bash
