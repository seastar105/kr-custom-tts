FROM espnet/espnet:gpu-latest

WORKDIR /root
RUN git clone https://github.com/espnet/espnet
RUN pip install g2pk ffmpeg-normalize
RUN pip install git+https://github.com/espnet/espnet
RUN ln -s /espnet/tools/kaldi /root/espnet/tools/kaldi
