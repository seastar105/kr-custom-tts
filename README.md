# kr-custom-tts

kr-custom-tts는 한국어 TTS 모델을 만들기 위한 프로젝트입니다. 본 레포지토리는 ESPNet의 tts recipe 형식을 따르고 있습니다. 

음성 데이터를 녹음하고 이를 Google Colab 혹은 GPU 머신을 사용하여 TTS 모델을 훈련시킵니다. 훈련이 끝난 모델을 사용하여 간단한 API 서버를 만드는 방법은 [링크](https://github.com/seastar105/kr-custom-tts-server)를 참고해주세요.

녹음을 위한 문장은 [KSS 데이터셋](https://www.kaggle.com/datasets/bryanpark/korean-single-speaker-speech-dataset)과 [카이스트 오디오북 데이터셋](https://aihub.or.kr/opendata/kaist-audiobook)의 일부를 사용하고 있습니다.

학습을 진행하기 위해서는 먼저 녹음이 필요합니다. 이를 위해 jupyter notebook을 사용하여 Recording.ipynb를 녹음을 진행하실 수도 있습니다. 

Recording.ipynb를 사용하지 않고 녹음을 진행하실 경우 `org/transcripts.txt`를 참고하셔서 녹음을 진행하신 뒤 org 폴더 안에 음성 파일들을 저장해주세요. `org/transcripts.txt`는 다음과 같은 형식을 취하고 있습니다.


```
파일이름1|문장1
파일이름2|문장2
.
.
.
```

파일이름과 문장의 짝을 잘 맞춰서 org 폴더 내에 음성파일을 저장해주세요. 그 뒤 학습에 대한 방법은 [학습 가이드](https://github.com/seastar105/kr-custom-tts/blob/main/Train_Guide.md)를 봐주세요.

만약, 자체적으로 모은 데이터가 있다면 `org`폴더 안에 음성파일들을 넣은 뒤, transcripts.txt를 형식에 맞게 수정해주세요. 그러면 해당 데이터만으로도 학습이 가능합니다. 

아래는 제 목소리로 훈련시킨 모델로 합성한 목소리 샘플입니다.


https://user-images.githubusercontent.com/30820469/173241162-f0f9c86e-8ced-44da-8666-cd438b34df1a.mp4


사용하는 라이브러리
- [ESPNet](https://github.com/espnet/espnet)
- [ffmpeg](https://ffmpeg.org/)
- [ffmpeg-normalize](https://github.com/slhck/ffmpeg-normalize)
- [g2pk](https://github.com/Kyubyong/g2pK)
- [ipywebrtc](https://github.com/maartenbreddels/ipywebrtc)
