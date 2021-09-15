# Sourced by rundist to distribute over the JAX cluster

module load miniconda/4.8.3

mkdir -p slurm

# DRMAA submission
snakemake -s ${SNAKEFILE} -j ${JOB_COUNT} \
    --nt --ri -k \
    --jobname "{rulename}.{jobid}" \
    --max-jobs-per-second 2 \
    --drmaa " -p {cluster.partition} --qos={cluster.qos} -n {cluster.cpu} --mem={cluster.mem} -t {cluster.rt} {cluster.params} -A beck-lab --output=$(pwd)/slurm/%j.out " \
    -w 60 -u ${SITE_CONFIG_DIR}/jax.slurm.json "$@"

# Shell submission
#snakemake -s ${SNAKEFILE} -j ${JOB_COUNT} \
#    --nt --ri -k \
#    --jobname "{rulename}.{jobid}" \
#    --cluster "sbatch -p {cluster.partition} -q {cluster.qos} -n {cluster.cpu} --mem={cluster.mem} -t {cluster.rt} {cluster.params} --output=$(pwd)/slurm/%j.out" \
#    -w 60 -u ${SITE_CONFIG_DIR}/jax.slurm.json "$@"

# Eichler lab
#    --drmaa " -V -cwd -j y -o ./log -l centos=7 -pe serial {cluster.cpu} -l mfree={cluster.mem} -l disk_free={cluster.disk} -l h_rt={cluster.rt} {cluster.params} -w n -S /bin/bash" \
#    -w 60 -u ${PAV_SITE_CONFIG_BUILTIN}/sge.json "$@"
