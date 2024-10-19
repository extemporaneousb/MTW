# Minimalist Mitochondrial Sequencing Workflow


## Quickstart

These instructions use `brew` to install system dependencies, however,
the package is expected to function on most Unix-like systems with the
dependencies installed in the appropriate way for that system. 

1. Install Dependencies
```
brew install python3 bcftools bwa samtools
```

2. Install Minimalist Mitochondrial Sequencing Workflow Package
```
python3 -m venv ~/.mtw_virtualenv && \
    source ~/.mtw_virtualenv/bin/activate && \
    pip install https://github.com/extemporaneousb/MTW/zipball/master
```

3. Make it easy to call the scripts on the system.
```
sudo ln -s ~/.mtw_virtualenv/bin/process_samples /usr/local/bin/process_samples
sudo ln -s ~/.mtw_virtualenv/bin/summarize_samples /usr/local/bin/summarize_samples
```

4. Align reads to reference and generate vcf and tsv outputs.**
```
process_samples -o Results <directory-of-fastq-files>
```
 
5. Compute heteroplasmy on the samples 
   and write output to summary.tsv.
```
summarize_samples -o summary.tsv Results
```

** Note: <directory-of-fastq-files> must be a directory containing
         a forward and a reverse fastq file for each sample.


## Overview

### `process_samples`

Compute variant statistics and measures of heteroplasmy for a
mitochondrial sequencing sample composed of two fastq files
representing forward and reverse reads from an Illumina paired-end
sequencing run, e.g.,

```
├── KB-001335-224_S64_L001_R1_001.fastq
├── KB-001335-224_S64_L001_R2_001.fastq
```

### `summarize_samples`

Aggregate sample-level heteroplasmy statistics from a directory
produced by `process_samples`. 
   









