#!/bin/bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set=train
valid_set=dev

langs="106"
recog="106"

test_sets=""
for l in ${recog}; do
  test_sets="dev_${l} eval_${l} ${test_sets}"
done
test_sets=${test_sets%% }

nlsyms_txt=data/nlsym.txt


./tts.sh \
    --train_set "${train_set}" \
    --local_data_opts "--langs ${langs} --recog ${recog}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --srctexts "data/${train_set}/text" "$@"
