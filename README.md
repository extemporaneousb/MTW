# Minimalist Mitochondrial Sequencing Workflow


## Quickstart

1. Install Dependencies

```
brew install bcftools bwa python3 r samtools
```

2. Install Minimalist Mitochondrial Sequencing Workflow Package

```
pip3 install https://github.com/extemporaneousb/MTW/zipball/master
```

3. Align reads to reference and generate vcf and tsv outputs 

```
process_samples Reads
```
 
4. Summarize tsv outputs from step 3 by aggregating across samples.

```
summarize_samples Results
```

## Objectives

1. Compute variant statistics and measures of heteroplasmy for a
   mitochondrial sequencing sample composed of two fastq files
   representing forward and reverse reads from an Illumina paired-end
   sequencing run, e.g.,

   ```
   ├── KB-001335-224_S64_L001_R1_001.fastq
   ├── KB-001335-224_S64_L001_R2_001.fastq
   ```

2. Aggregate sample-level heteroplasmy statistics.
   

## Installation

This package was developed on Mac, but should work without
modification on any Unix. On Mac we use `brew` to install packages; on
other platforms use the appropriate package manager.

### Backup Current Packages

```
brew list > .backup_package_list_`date -I`.txt
```

### Update Brew Package List

```
brew update && brew upgrade
```

### Install Dependencies

```
brew install bcftools bwa gnuplot markdown pandoc python3 r readline \
  samtools
```

### Install MTW Python Package

```
pip3 install MTW
```

One might consider running a virtual environment as opposed to
installing in the system python. To do this, run:


```
python3 -m venv .VE
```

Then

```
. .VE/bin/activate
pip install MTW
```


## Running

The two main command-line programs provided are:

`process_samples` - takes an input directory which must contain one or
more pairs of FASTQ files from Illumina Paired End sequencing
runs. Each pair of files must represent a single sample - the result
of demultiplexing barcoded illumina sequencing reads. For example, in
the folder containing this file, the `Data` directory,
```
Data
├── KB-001350-224_S62_L001_R1_001.fastq
└── KB-001350-224_S62_L001_R2_001.fastq
```
containing two samples, with 1 forward and 1 reverse read fastq file
for each sample. 

This produces a large number of output files in the output directory
specified by the user. 


`summarize_samples` - takes a directory containing results from
running `process_samples` and creates a summary table for all of the
samples contained in the input directory. 








