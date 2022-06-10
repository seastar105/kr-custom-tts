import os
import shutil

script_file = 'raw/train/transcripts.txt'

transcripts = []
for line in open(script_file, 'rt'):
    transcripts.append(line.strip())

# use 10 utterances as eval set
cnt = 5
train_scripts, eval_scripts = transcripts[cnt:-cnt], transcripts[:cnt]+transcripts[-cnt:]

open('raw/train/transcripts.txt', 'w').write('\n'.join(train_scripts))
open('raw/eval/transcripts.txt', 'w').write('\n'.join(eval_scripts))
os.makedirs('raw/eval/wavs', exist_ok=True)

train_wav_dir = 'raw/train/wavs'
eval_wav_dir = 'raw/eval/wavs'

for line in eval_scripts:
    wav_file = line.split('|')[0]
    train_wav = os.path.join(train_wav_dir, wav_file)
    eval_wav = os.path.join(eval_wav_dir, wav_file)
    shutil.move(train_wav, eval_wav)
