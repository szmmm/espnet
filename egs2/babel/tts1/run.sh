#!/bin/bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

fs=8000
fmin=125           # Minimum frequency of Mel basis.
fmax=3800         # Maximum frequency of Mel basis.
n_fft=400        # The number of fft points.
n_shift=100
#win_length=200

train_set=train
valid_set=dev

langs="106"
test="106"
test_sets="dev_${langs} eval_${langs}"

train_config=conf/tuning/train_gst_tacotron2.yaml
inference_config=conf/tuning/decode_tacotron2.yaml

nlsyms_txt=data/nlsym.txt


./tts.sh \
    --lang tagalog \
    --feats_type raw \
    --fs "${fs}" \
    --fmax "${fmax}" \
    --fmin "${fmin}" \
    --n_fft "${n_fft}" \
    --n_shift "${n_shift}" \
    --token_type char \
    --cleaner tacotron \
    --train_config "${train_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --srctexts "data/${train_set}/text" "$@"
