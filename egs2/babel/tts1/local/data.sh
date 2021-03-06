#!/bin/bash
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

. ./path.sh || exit 1;
. ./cmd.sh || exit 1;
. ./db.sh || exit 1;

SECONDS=0

log() {
    local fname=${BASH_SOURCE[1]##*/}
    echo -e "$(date '+%Y-%m-%dT%H:%M:%S') (${fname}:${BASH_LINENO[0]}:${FUNCNAME[1]}) $*"
}


langs="106"
test="106"

for l in ${langs}; do
  if [ ! -e ${BABEL_106} ]; then
      log "Fill the value of 'BABEL_${l}' of db.sh"
      exit 1
  fi
done

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

# Train Directories
train_set=train
train_dev=dev

test_set=""
for l in ${test}; do
  test_set="dev_${l} eval_${l} ${test_set}"
done
test_set=${test_set%% }

./local/setup_languages.sh --langs "${langs}" --test "${test}"
#for x in ${train_set} ${train_dev} ${test_set}; do
#   sed -i.bak -e "s/$/ sox -R -G -t wav - -t wav - rate 8000 dither | /" data/${x}/wav.scp
#done

cut -f 2- data/${train_set}/text | tr " " "\n" | sort | uniq | grep "<" > data/nlsym.txt

log "Successfully finished. [elapsed=${SECONDS}s]"
