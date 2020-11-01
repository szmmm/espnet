qsub -cwd -j yes -S /bin/bash -l qp=cuda-low -l gpuclass='*' -l osrel='*' ./run_train_stage.sh



qsub -cwd -j y -hold_jid -1 -S /bin/bash -o $LOG -l qp=cuda-low -l gpuclass='*' ./run.sh --stage 1 --stop_stage 2

qsub -cwd -j yes -P esol -l qp=cuda-low -l gpuclass='*' -l osrel='*' ./run.sh --stage 1 --stop_stage 2
