# 훈련 가이드

학습을 위한 음성이 전부 끝났다면 `tts1/org`폴더는 아래와 같이 음성파일들과 `transcripts.txt`파일이 놓여 있을 겁니다.

```
org
├── 00000.wav
├── 00001.wav
├── 00002.wav
├── 00003.wav
├── 00004.wav
├── 00005.wav
.
.
.
├── 01008.wav
├── 01009.wav
├── 01010.wav
├── 01011.wav
├── 01012.wav
└── transcripts.txt
```



학습은 Google Colab을 이용하는 방식과 Docker를 사용하여 직접 GPU가 달린 컴퓨터에서 학습을 수행하는 두 가지 방식이 존재합니다.



## Google Colab

Google Colab을 이용하는 경우 Google Drive의 최상위 디렉토리에 org 폴더를 압축하여 org.zip으로 업로드해주세요. 

그 뒤 이 [노트북](https://colab.research.google.com/drive/1QK1zSEmnkT-AHAPRWrYcNGe277PiTuCt?usp=sharing)을 사용하시면 학습을 수행할 수 있습니다.  자세한 설명은 Google Colab의 노트북을 참고해주세요.





## Docker

학습을 수행할 수 있는 GPU 머신이 있거나 클라우드에서 빌려서 사용할 경우 docker를 사용한 학습도 가능합니다. 이를 위해서는 아래 프로그램들이 설치되어 있어야 합니다.

- [docker](https://www.docker.com/)
- [nvidia docker](https://github.com/NVIDIA/nvidia-docker)



`docker_run.sh`을 레포지토리의 최상위에서 실행하시면 컨테이너 안으로 들어가게 되고 아래 커맨드를 실행하시면 학습이 수행됩니다. 

```
cd /root/espnet/finetune/tts1 && ./all_in_one.sh
```

레포지토리 경로가 `/root/espnet/finetune`으로 마운트 됩니다. 학습의 로그는 `tts1/exp/tts_finetune_jets_raw_phn_null_g2pk/train.log`에 기록됩니다. 추가로 로그를 확인하는 방법은 `tensorboard`와 `Weights&Biases`가 있습니다.



### Tensorboard

컨테이너는 외부의 6006번 포트와 연결되어 있습니다. 따라서 컨테이너 내부에서 `tensorboard --logdir /root/espnet/finetune/tts1/exp/tts_finetune_jets_raw_phn_null_g2pk/tensorboard`를 실행하면 텐서보드가 실행되고 6006번 포트를 통해 확인 가능합니다.



### Weights & Biases

Weights&Biases를 통해 로그를 확인하실 수도 있습니다. 이 경우 컨테이너 안에서 `wandb login`을 실행하여 api key를 등록한 학습을 아래와 같은 커맨드로 실행해주시면 됩니다.

```
cd /root/espnet/finetune/tts1 && ./all_in_one.sh --train_args "--init_param models--imdanboy--kss_tts_train_jets_raw_phn_null_g2pk_train.total_count.ave/snapshots/b059fd8f0fefd7c779cdca610fd29ab7cab692cf/exp/tts_train_jets_raw_phn_null_g2pk/train.total_count.ave_5best.pth:tts:tts --use_wandb true --wandb_entity [wandb 계정] --wandb_project [프로젝트 이름]"
```





### 중간에 오류가 발생하여 학습이 취소된 경우

#### Out of Memory 에러 발생 시

GPU의 메모리가 부족하여 Out of Memory 에러가 발생할 수 있습니다. 이 경우 `tts1/conf/tuning/finetune_jets.yaml`에서 `batch_bins`를 줄이신 뒤에 `exp/tts_finetune_jets_raw_phn_null_g2pk/run.sh`를 실행하여 다시 학습을 시작할 수 있습니다.
