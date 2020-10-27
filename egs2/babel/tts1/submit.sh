qsub -cwd -j yes -l qp=cuda-low -l gpuclass='*' -l osrel='*' ./run.sh --stage 6 --stop-stage 7 --ngpu 4
