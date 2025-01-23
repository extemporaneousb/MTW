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

6. Compute heteroplasmy on the samples and exclude problematic sites
   specified as follows:
```
summarize_samples -e 303-315 -e 3100-3110 -o summary.tsv Results
```


** Note: <directory-of-fastq-files> must be a directory containing
         a forward and a reverse fastq file for each sample.


## Updating the Package from Github

To updated the installed package from Github, one need only run the
following commands:

```
source ~/.mtw_virtualenv/bin/activate && \
    pip install https://github.com/extemporaneousb/MTW/zipball/master
```

One can add the `-v` flag to `process_samples` and `summarize_samples`
to increase the logging output.


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

```
Usage: process_samples [-fnvk] [-o <outdir>] [-r <refseq>] <reads_dir>

Options:

-o <outdir>   Write results to outdir [default: ./Results]


-f            Force execution. process_reads.py does not re-run previously
              completed executions if the output exists in <outdir>. This
              option forces make to completely re-execute using the '-B' option
              (ignore dependency checks).

-n            Print commands that would be executed without performing any action.

-v            Print more detailed output during execution.

-k            Keep all output files - useful when repeatedly processing a
              directory of FASTQ files

-r <refseq>   Use refseq as the reference sequence to align the reads to.

Arguments:

<reads_dir>   Directory containing pairs of fastq files for each sample,
              one for forward and one for reverse reads from PE
              sequencing run.
```


### `summarize_samples`

Aggregate sample-level heteroplasmy statistics from a directory
produced by `process_samples`. 

```
Usage: summarize_samples [-vs] [-e <exclude_range>]... [-o <summary_tsv>] <results_dir>


Write a tab-delimited file containing the following columns:

|column name  | Description
--------------------------------------------------------------------------------
|sample_name  | The name of the sample derived from the filename:
                `sample_name_pileup.tsv`
|mean_dp      | Average number of reads per base
|median_dp    | Median number of reads per base
|q05_dp       | 5th percentile number of reads per base
|q10_dp       | 10th percentile number of reads per base
|q90_dp       | 90th percentile number of reads per base
|q95_dp       | 95th percentile number of reads per base
|n_sites10_90 | Count of the number of sites with a variant that occurs within
                10 to 90 percent of the reads for that site (aka, Heteroplasmy)
|sites10_90*   | The base position of all sites falling within the above range
                (aka, Heteroplasmic Sites)
--------------------------------------------------------------------------------
* This column is included only if one specifies the '-s' option.

Options:

-v                     Print more detailed output during execution.

-s                     Output heteroplasmic site locations. This will
                       result in a comma-separated list including all sites
                       falling within the range of 10 and 90 percent.

-e <exclude_range>     Exclude the range (inclusive) from heteroplasmy statistics.
                       If more than one range is required, repeat this argument.

-o <summary_tsv>       The output file for the summary.

Arguments:

<results_dir>          Directory containing results from running 'process_samples'
```


### `haplogroup_samples`

#### Prerequisites

To call `haplogroup_samples` Java needs to be installed and available
in the users path. This is most directly achieved using `brew`:

```
brew install openjdk
```

And then adding the openjdk bin directory to your path. You can do
this directly by issuing the following command:

```
echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
```

Restart the terminal and check that `java` is in your path:

```
which java
```

#### `haplogroup_samples`

Calls `haplogrep3` on a results directory of VCF files producing a
`haplogroups.tsv` with a single line for each `call` VCF file in the
results directory.

```
Usage: haplogroup_samples [-v] [--tree <phylotree>] [-o <haplogroups_tsv>] <results_dir>

Call haplogrep3 on VCF files in <results_dir>.

Options:

-v                     Print more detailed output during execution.

--tree <phylotree>     The tree to use for haplogrep3. [default: phylotree-fu-rcrs@1.2]

-o <haplogroups_tsv>   Write output to file. [default: haplogroups.tsv]

Arguments:

<results_dir>          Directory containing results from running 'process_samples'
```








