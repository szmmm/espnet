qsub -cwd -j y -o $LOG -l qp=cuda-low -l gpuclass='*' -l osrel='*' ./run.sh --stage 1 --stop-stage 2 --ngpu 4
