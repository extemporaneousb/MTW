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
pip3 install https://github.com/extemporaneousb/MTW/zipball/master
```

3. Align reads to reference and generate vcf and tsv outputs.**

```
process_samples -o Results <directory-of-fastq-files>
```
 
4. Compute heteroplasmy on the samples processed from step (3) above
   and write output to summary.tsv.

```
summarize_samples -o summary.tsv Results
```

** Note: <directory-of-fastq-files> must be a directory containing
         readable fastq files 2 files per sample - forward and reverse 
         reads.


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
   









