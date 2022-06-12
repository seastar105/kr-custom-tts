# kr-custom-tts

kr-custom-tts는 한국어 TTS 모델을 만들기 위한 프로젝트입니다. 본 레포지토리는 ESPNet의 tts recipe 형식을 따르고 있습니다. 

음성 데이터를 녹음하고 이를 Google Colab 혹은 GPU 머신을 사용하여 TTS 모델을 훈련시킵니다. 훈련이 끝난 모델을 사용하여 간단한 API 서버를 만드는 방법은 [링크](https://github.com/seastar105/kr-custom-tts-server)를 참고해주세요.

녹음을 위한 문장은 [KSS 데이터셋](https://www.kaggle.com/datasets/bryanpark/korean-single-speaker-speech-dataset)과 [카이스트 오디오북 데이터셋](https://aihub.or.kr/opendata/kaist-audiobook)의 일부를 사용하고 있습니다.

음성 데이터의 녹음은 Recording.ipynb를 사용해서 진행해주세요.

사용하는 라이브러리
- [ESPNet](https://github.com/espnet/espnet)
- [ffmpeg](https://ffmpeg.org/)
- [ffmpeg-normalize](https://github.com/slhck/ffmpeg-normalize)
- [g2pk](https://github.com/Kyubyong/g2pK)
- [ipywebrtc](https://github.com/maartenbreddels/ipywebrtc)
