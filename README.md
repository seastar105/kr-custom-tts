# kr-custom-tts

kr-custom-tts는 한국어 TTS 모델을 만들기 위한 프로젝트입니다. 본 레포지토리는 ESPNet의 tts recipe 형식을 따르고 있습니다. 

음성 데이터를 녹음하고 이를 Google Colab 혹은 GPU 머신을 사용하여 TTS 모델을 훈련시킵니다. 훈련이 끝난 모델을 사용하여 간단한 API 서버를 만드는 방법은 [링크](https://github.com/seastar105/kr-custom-tts-server)를 참고해주세요.

녹음을 위한 문장은 [KSS 데이터셋](https://www.kaggle.com/datasets/bryanpark/korean-single-speaker-speech-dataset)과 [카이스트 오디오북 데이터셋](https://aihub.or.kr/opendata/kaist-audiobook)의 일부를 사용하고 있습니다.


```
org
├── 00000.wav
├── 00001.wav
├── 00002.wav
├── 00003.wav
├── 00004.wav
├── 00005.wav
├── 00006.wav
├── 00007.wav
..
..
..
├── 00290.wav
├── 00291.wav
├── 00292.wav
├── 00293.wav
├── 00294.wav
├── 00295.wav
├── spk_id
└── transcripts.txt
```

사용하는 라이브러리

- [ESPNet](https://github.com/espnet/espnet)
- [ffmpeg-normalize](https://github.com/slhck/ffmpeg-normalize)
- [g2pk](https://github.com/Kyubyong/g2pK)
