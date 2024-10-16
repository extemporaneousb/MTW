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
process_samples -o Results Reads
```
 
4. Compute heteroplasmy on the samples processed from step (3) above
   and write output to summary.tsv.

```
summarize_samples -o summary.tsv Results
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
modification on any Unix. On Mac we use `brew` to install dependencies
and pip to install the package.

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








