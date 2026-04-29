#!/bin/bash
#SBATCH --job-name=CHECKM2  # Give your experiment a name
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --partition=rome #  # turing --> gpu, dhabi, naples and rome ---> cpu
#SBATCH --mem=96G
#SBATCH --mail-type=NONE  # Type of email notification: BEGIN,END,FAIL,ALL,NONE
#SBATCH --mail-user=abce@cs.aau.dk
#SBATCH --time=48:00:00  #  time limit in dd:hh:mm:ss format. 


# CheckM2 TEST RUN
/nfs/home/cs.aau.dk/zs74qz/biocloud_setup/SemiBin/envs/checkm2/bin/checkm2 testrun

