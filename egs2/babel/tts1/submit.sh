qsub -cwd -j yes -P esol -l qp=cuda-low -l gpuclass='*' -l osrel='*' ./run.sh --stage 6 --stop-stage 6 --ngpu 4
