#### Clone the SemiBin2 repository and checkout the specific version (v2.2.1)
```
git clone https://github.com/BigDataBiology/SemiBin.git
cd SemiBin
git checkout 59122f2
cd ..
```

#### Create and activate the SemiBin2 environment
```
mkdir envs
conda create -p envs/semibin python=3.12
conda activate envs/semibin
```

#### Configure MPI & CUDA environment
```
export OMPI_MCA_opal_cuda_support=true
export OMPI_MCA_pml="ucx"
export OMPI_MCA_osc="ucx"
```

#### Install dependencies
```
conda install -c conda-forge ucx
conda install cuda-cudart cuda-version=12
```

#### Install necessary bioinformatics tools
```
conda install -c bioconda bedtools hmmer samtools
```

#### Install SemiBin
```
cd SemiBin
srun --cpus-per-task 8 --mem 64G --time 0-04:00:00 pip install .
```

#### Install CheckM2
```
conda deactivate
conda create -p envs/checkm2 -c bioconda -c conda-forge checkm2
conda activate envs/checkm2
checkm2 database --setdblocation /databases/checkm2/CheckM2_database/uniref100.KO.1.dmnd
```

#### (Optional) Run CheckM2 tests
```
srun --cpus-per-task 8 --mem 64G --time 0-04:00:00 checkm2 testrun
```
