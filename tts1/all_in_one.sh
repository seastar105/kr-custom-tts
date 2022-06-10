#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# data prep
local/data.sh

if [ -z ${expdir+x} ]; then expdir=exp; fi

# data -> dump
./run.sh \
    --tts_task gan_tts \
    --min_wav_duration 0.683 \
    --fs 24000 \
    --fmin 0 \
    --fmax null \
    --n_fft 1024 \
    --n_shift 256 \
    --win_length null \
    --train_config conf/tuning/finetune_jets.yaml \
    --token_type phn \
    --g2p g2pk \
    --cleaner null \
    --stage 2 \
    --stop-stage 5 \
    --expdir ${expdir}

# setup pretrained_model
local/setup_pretrained_model.sh

# start train
./run.sh \
    --tts_task gan_tts \
    --min_wav_duration 0.683 \
    --fs 24000 \
    --fmin 0 \
    --fmax null \
    --n_fft 1024 \
    --n_shift 256 \
    --win_length null \
    --train_config conf/tuning/finetune_jets.yaml \
    --token_type phn \
    --g2p g2pk \
    --cleaner null \
    --stage 6 \
    --train_args "--init_param downloads/imdanboy--kss_tts_train_jets_raw_phn_null_g2pk_train.total_count.ave.main.b059fd8f0fefd7c779cdca610fd29ab7cab692cf/exp/tts_train_jets_raw_phn_null_g2pk/train.total_count.ave_5best.pth:tts:tts" \
    --tag finetune_jets_raw_phn_null_g2pk \
    --inference_model train.total_count.best.pth \
    --expdir ${expdir}

