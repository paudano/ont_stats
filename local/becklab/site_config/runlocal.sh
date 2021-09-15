# Sourced by rundist to run in current session (no distribution)

module load miniconda/4.8.3

snakemake -s ${SNAKEFILE} -j ${JOB_COUNT} \
    --nt --ri -k \
    --jobname "{rulename}.{jobid}" \
    -w 60 "$@"
