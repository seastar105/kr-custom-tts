#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# org -> raw/train
mkdir -p tmp
mkdir -p raw/train

# normalize and resample
for f in org/*;
do
    base=$(basename $f)
    base=${base%%.*}
    if [[ $base == "spk_id" ]]; then
        continue
    fi
    if [[ $base == "transcript" ]]; then
	continue
    fi
    ffmpeg-normalize $f -nt rms -o tmp/$base.wav
    ffmpeg -i tmp/$base.wav -ar 24000 -ac 1 -sample_fmt s16 raw/train/wavs/$base.wav
done

# split train, eval
mkdir -p raw/eval
python local/split_data.py
echo "tmp_spk" >> raw/spk

rm -r tmp
