#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# normalize and resample
local/org_to_raw.sh

# make kaldi format
python local/make_kaldi_format.py

# fix data
utils/fix_data_dir.sh data/train
utils/fix_data_dir.sh data/eval

# trim silence
local/trim_silence.sh
