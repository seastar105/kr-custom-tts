#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# Download JETS model trained on kss
. ./path.sh
espnet_model_zoo_download --unpack true --cachedir downloads imdanboy/kss_tts_train_jets_raw_phn_null_g2pk_train.total_count.ave

# Generate token list used for training kss
pyscripts/utils/make_token_list_from_config.py downloads/models--imdanboy--kss_tts_train_jets_raw_phn_null_g2pk_train.total_count.ave/snapshots/b059fd8f0fefd7c779cdca610fd29ab7cab692cf/exp/tts_train_jets_raw_phn_null_g2pk/config.yaml

# Substitue tokens with current one
mv dump/token_list/phn_null_g2pk/tokens.{txt,txt.bak}
cp downloads/models--imdanboy--kss_tts_train_jets_raw_phn_null_g2pk_train.total_count.ave/snapshots/b059fd8f0fefd7c779cdca610fd29ab7cab692cf/exp/tts_train_jets_raw_phn_null_g2pk/tokens.txt dump/token_list/phn_null_g2pk/
