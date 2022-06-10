import os

def check_exist(path):
    assert os.path.exists(path), f'{path} does not exist'

raw_dir = 'raw'
spk_file = 'spk'

# assume previous steps are performed well

with open(os.path.join(raw_dir, spk_file), 'r') as f:
    spk_id = f.read().strip()

def save_wav_scp(base, utts, wavs):
    lines = []
    for utt, wav in zip(utts, wavs):
        lines.append(str(utt) + ' ' + str(wav))
    open(os.path.join(base, 'wav.scp'), 'w').write('\n'.join(lines))

def save_text(base, utts, texts):
    lines = []
    for utt, text in zip(utts, texts):
        lines.append(str(utt) + ' ' + str(text))
    open(os.path.join(base, 'text'), 'w').write('\n'.join(lines))

def save_utt2spk(base, utts, spk_id):
    lines = []
    for utt in utts:
        lines.append(str(utt) + ' ' + str(spk_id))
    open(os.path.join(base, 'utt2spk'), 'w').write('\n'.join(lines))

kaldi_base = 'data'
for dset in ['train', 'eval']:
    data_dir = os.path.join(kaldi_base, dset)
    os.makedirs(data_dir, exist_ok=True)
    text_file = 'transcripts.txt'
    dset_dir = os.path.join(raw_dir, dset)
    wavs = []
    texts = []
    utts = []
    for line in open(os.path.join(dset_dir, text_file), 'rt'):
        wav_file, text = line.strip().split('|')
        utt = wav_file.split('.')[0]
        wavs.append(os.path.join(dset_dir, 'wavs', wav_file))
        utts.append(utt)
        texts.append(text)
    save_wav_scp(data_dir, utts, wavs)
    save_text(data_dir, utts, texts)
    save_utt2spk(data_dir, utts, spk_id)
