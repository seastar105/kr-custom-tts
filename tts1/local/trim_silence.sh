#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# trim silence at start and end using kaldi's script
fs=24000
for dset in "train" "eval";
do
    datadir=data/${dset}
    scripts/audio/trim_silence.sh \
        --fs ${fs} \
        ${datadir} ${datadir}/log
    # fix dset since segments file added
    utils/fix_data_dir.sh ${datadir}
done
