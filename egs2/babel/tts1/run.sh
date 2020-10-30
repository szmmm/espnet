#!/bin/bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

fs=16000
n_fft=2048
n_shift=300
win_length=1200

train_set=train
valid_set=dev

langs="106"
test="106"
test_sets="dev_${l} eval_${l}"

train_config=conf/train.yaml
inference_config=conf/decode.yaml

nlsyms_txt=data/nlsym.txt


./tts.sh \
    --feats_type raw \
    --token_type phn \
    --cleaner tacotron \
    --train_config "${train_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --srctexts "data/${train_set}/text" "$@"
