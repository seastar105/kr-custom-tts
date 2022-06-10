#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# normalize and resample
local/org_to_raw.sh

# make kaldi format
python local/make_kaldi_format.py
