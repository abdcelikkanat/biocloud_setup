#!/usr/bin/bash -l
#SBATCH --job-name=TESTJOB # ------------> update
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=zen5
#SBATCH --cpus-per-task=1
#SBATCH --mem=96G
#SBATCH --time=3-00:00:00
#SBATCH --mail-type=NONE # --------------> update
#SBATCH --mail-user=abce@cs.aau.dk #-----> update
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err

# Exit on first error and if any variables are unset
set -eu


# Define the project and data folders
PROJECT_FOLDER=/home/cs.aau.dk/zs74qz/workspace/luis
DATA_FOLDER=/projects/dark_science/methylation_binning/development/data/datasets
CHECKM2_DATABASE=/databases/checkm2/CheckM2_database/uniref100.KO.1.dmnd

# Define the paths of tools
SEMIBIN2_EXE=${PROJECT_FOLDER}/envs/semibin/bin/SemiBin2
CHECKM2_EXE=${PROJECT_FOLDER}/envs/checkm2/bin/checkm2

# Define the input and outout paths
DATASET_NAME=fecal_deep
FASTA_FILE_PATH=${DATA_FOLDER}/${DATASET_NAME}/myloasm/eukfilt_assembly.fasta
BAM_FILE_PATH=${DATA_FOLDER}/${DATASET_NAME}/myloasm/1_cov.bam
OUTPUT_FOLDER=${PROJECT_FOLDER}/outputs/${DATASET_NAME}
BINS_FOLDER=${PROJECT_FOLDER}/outputs/${DATASET_NAME}/output_bins
CHECKM2_OUTPUT_FOLDER=${PROJECT_FOLDER}/outputs/${DATASET_NAME}/checkm2

# Define SemiBin2 parameters
MIN_CONTIG_LEN=3000
SEQ_TYPE=long_read
SEMIBIN_THREADS=32
CHECKM2_THREADS=32

# Create the output folder if not exists
mkdir -p ${DATASET_NAME}

# Run SemiBin2
CMD="${SEMIBIN2_EXE} single_easy_bin --input-fasta ${FASTA_FILE_PATH} -b ${BAM_FILE_PATH} -o ${OUTPUT_FOLDER}"
CMD="${CMD} -m ${MIN_CONTIG_LEN} --sequencing-type ${SEQ_TYPE} -p ${SEMIBIN_THREADS}"
$CMD


# Run CheckM2
export CHECKM2DB=${CHECKM2_DATABASE}
CMD="${CHECKM2_EXE} predict -i ${BINS_FOLDER}/* -o ${CHECKM2_OUTPUT_FOLDER} -x .fa"
CMD="${CMD} -t ${CHECKM2_THREADS} --force"
$CMD
