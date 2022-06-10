#!/usr/bin/env bash

# Copyright 2021 Tomoki Hayashi
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Feature related
fs=24000
n_fft=1024
n_shift=256
win_length=null

# Data prep related
text_format=raw  # Use "raw" or "phn". If use "phn", convert to phn in data prep.
local_data_opts=""
local_data_opts+=" --text_format ${text_format}"

dset_suffix=""
train_set=train
valid_set=eval
test_sets=eval

# Config related
train_config=conf/train.yaml
inference_config=conf/decode.yaml

# NOTE(kan-bayashi): Make sure that you use text_format=raw
#   if you want to use token_type=char.
token_type=phn

g2p=g2pk
# g2p=g2pk_no_space  # No word sparator

# Default settings for non-vits models
tts_task=gan_tts
feats_extract=fbank
feats_normalize=global_mvn

# data prep
local/data.sh

# data -> dump
./tts.sh \
    --tts_task "${tts_task}" \
    --feats_extract "${feats_extract}" \
    --feats_normalize "${feats_normalize}" \
    --local_data_opts "${local_data_opts}" \
    --audio_format wav \
    --lang ko \
    --feats_type raw \
    --fs "${fs}" \
    --n_fft "${n_fft}" \
    --n_shift "${n_shift}" \
    --win_length "${win_length}" \
    --token_type "${token_type}" \
    --cleaner none \
    --g2p "${g2p}" \
    --train_config "${train_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --srctexts "data/${train_set}/text" \
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
    "$@"


# setup pretrained_model
local/setup_pretrained_model.sh

# start train
./tts.sh \
    --tts_task "${tts_task}" \
    --feats_extract "${feats_extract}" \
    --feats_normalize "${feats_normalize}" \
    --local_data_opts "${local_data_opts}" \
    --audio_format wav \
    --lang ko \
    --feats_type raw \
    --fs "${fs}" \
    --n_fft "${n_fft}" \
    --n_shift "${n_shift}" \
    --win_length "${win_length}" \
    --token_type "${token_type}" \
    --cleaner none \
    --g2p "${g2p}" \
    --train_config "${train_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --srctexts "data/${train_set}/text" \
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
    --train_args "--use_wandb true --wandb_project JHS-finetune-joint-config --wandb_entity seastar105" \
    --inference_model train.total_count.best.pth \
    "$@"
