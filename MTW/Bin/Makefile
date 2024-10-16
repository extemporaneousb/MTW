# Get the absolute path to this Makefile dynamically
MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

# Propagate the dynamically obtained Makefile path using MAKEFLAGS
MAKEFLAGS += -f $(MAKEFILE_PATH)

##
## Makefile for processing a pair of fastq files
## 
REFSEQ ?= Reference/NC_012920_human_mito_dna.fasta
INNAME ?= KB-001335-224_S64_L001
INDIR  ?= Data
OUTDIR ?= Results

INF := $(shell ls $(INDIR)/$(INNAME)_R1*.fastq)
INR := $(shell ls $(INDIR)/$(INNAME)_R2*.fastq)

$(info |info|: Reference Sequence $(REFSEQ))
$(info |info|: Forward Reads: $(INF))
$(info |info|: Reverse Reads: $(INR))
$(info |info|: Results Directory: $(OUTDIR))

IDX_EXTS := sa amb ann bwt pac
REFIDX   := $(foreach xte, $(IDX_EXTS), $(REFSEQ).$(xte))

OUTBAM := $(OUTDIR)/$(INNAME).bam
DUP_STATS := $(OUTDIR)/$(INNAME)_dup_stats.txt

OUTBCF := $(OUTDIR)/$(INNAME).bcf
OUTVCF := $(OUTDIR)/$(INNAME).vcf

OUTBCF_CALLS := $(OUTDIR)/$(INNAME)_calls.bcf
OUTVCF_CALLS := $(OUTDIR)/$(INNAME)_calls.vcf

OUTTSV := $(OUTDIR)/$(INNAME)_pileup.tsv
OUTTSV_CALLS := $(OUTDIR)/$(INNAME)_calls.tsv

OUTCONSENSUS := $(OUTDIR)/$(INNAME)_consensus.fasta

all: index-ref align call-variants tsv vcf consensus

## We can use this target to call the Makefile on the results of running `all`.
all-without-consensus: index-ref align call-variants tsv vcf

## Index
index-ref: $(REFIDX)

## Align
align: $(OUTBAM)

## Variants
call-variants: $(OUTBCF) $(OUTBCF_CALLS)

## Consensus
consensus: $(OUTCONSENSUS)

## Generate Summary Files
tsv: $(OUTTSV) $(OUTTSV_CALLS)

vcf: $(OUTVCF) $(OUTVCF_CALLS)

## Cleaning up
clean-index:
	rm -f $(REFIDX)
clean-alignments:
	rm -f $(OUTBAM) $(OUTBAM).bai $(DUP_STATS)
clean-variants:
	rm -f $(OUTBCF) $(OUTBCF_CALLS) $(OUTCONSENSUS) $(OUTBCF).bcf.csi $(OUTBCF_CALLS).bcf.csi
clean-tsv:
	rm -f $(OUTTSV) $(OUTTSV_CALLS)
clean-vcf:
	rm -f $(OUTVCF_CALLS) $(OUTVCF)

clean: clean-alignments clean-variants clean-tsv clean-vcf

clean-all: clean-index clean

.PHONY: clean clean-all clean-index clean-alignments clean-variants	\
	clean-tsv clean-vcf all all-without-consensus index-ref align			\
	call-variants consensus tsv vcf

##
## From here on, we have the actual calls to produces the results.
##
$(REFIDX): $(REFSEQ)
	bwa index $(REFSEQ)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(OUTBAM): $(OUTDIR) $(INF) $(INR) $(REFIDX)
	bwa mem -t 8 $(REFSEQ) $(INF) $(INR) \
	| samtools fixmate -O BAM -mru - - \
	| samtools sort -O bam -u - \
	| samtools markdup -f $(DUP_STATS) -@8 --reference $(REFSEQ) - $(OUTBAM)
	samtools index -b -o $(OUTBAM).bai $(OUTBAM)

## BAM->Pileup
$(OUTBCF): $(OUTBAM)
	bcftools mpileup -W -Ob --ignore-RG -a "FORMAT/DP,FORMAT/QS,INFO/AD,INFO/SCR" --max-depth 10000 -f $(REFSEQ) -o $@ $^

## PILEUP->CALLS
$(OUTBCF_CALLS): $(OUTBCF)
	bcftools call -m -W -Ob -A -v --ploidy 1 -a "FORMAT/GP" $^ -o $@

## CALLS->CONSENSUS
$(OUTCONSENSUS): $(OUTBCF_CALLS)
	bcftools consensus -f $(REFSEQ) $(OUTBCF_CALLS) -o $(OUTCONSENSUS)

## Make TSVs
$(OUTTSV): $(OUTBCF)
	bcftools query -H -f'%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%DP\t[%AD]\n' -o $(OUTTSV) $(OUTBCF) 

$(OUTTSV_CALLS): $(OUTBCF_CALLS)
	bcftools query -H -f'%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%DP\t%DP4\t[%AD]\n' -o $(OUTTSV_CALLS) $(OUTBCF_CALLS)

## Generate Text VCFs
$(OUTVCF_CALLS): $(OUTBCF_CALLS) 
	bcftools view -o $@ $^

$(OUTVCF): $(OUTBCF)
	bcftools view -o $@ $^
