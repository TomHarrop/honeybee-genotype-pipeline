# honeybee genotype pipeline

Preconfigured pipeline for converting Illumina reads into VCF for *Apis mellifera*.

1. Check pairing
2. Strict barcode check 
3. Filter contaminants
4. Trim adaptors
5. Map against reference genome
6. Call SNPs with `freebayes` (each contig run separately in parallel)
7. Genotyping stats (**not implemented**)

In another pipeline (coming soon):

- Make a set of haplotypes from the haploid individuals (drones)
- Use whatshap to set this as a haplotype and phase the pools

## Install

[![](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/3839)

Use the singularity container hosted on [Singularity hub](https://singularity-hub.org/collections/3839).

```
bbmap 38.73
bwa 0.7.17-r1188
freebayes 1.3.1
python 3.7.5
samtools 1.9 and bcftools 1.9 using htslib 1.9
vcflib 1.0.1
```

If you have the above dependencies installed, you can install the pipeline with `pip3`:

```bash
pip3 install \
    git+git://github.com/tomharrop/honeybee-genotype-pipeline.git
```

## Usage

- `ref`: Reference genome (uncompressed fasta).
- `samples_csv`: a csv file with the following columns:
    - `sample`: sample name (will be propagated to output files and VCF);
    - `barcode`: sample barcode, will be checked with 0 allowed mismatches;
    - `r1_path`: path to R1 file;
    - `r2_path`: path to R2 file;
    - `metadata` (optional): currently not used.
- `outdir`: Output directory.
- `ploidy`: Ploidy for freebayes, e.g. 1 for haploid, 2 for diploid.
- `threads`: Number of threads to use. Intermediate files are pipes, so at least 4 threads are required.
- `restart_times`: Number of times to restart failing jobs.

```
honeybee-genotype-pipeline [-h] --ref REF --samples_csv SAMPLES_CSV
                                  --outdir OUTDIR [--ploidy PLOIDY]
                                  [--threads int]
                                  [--restart_times RESTART_TIMES] [-n]

optional arguments:
  -h, --help            show this help message and exit
  --ref REF             Reference genome in uncompressed fasta
  --samples_csv SAMPLES_CSV
                        Sample csv (see README)
  --outdir OUTDIR       Output directory
  --ploidy PLOIDY       Ploidy for freebayes (e.g. 1 for haploid, 2 for
                        diploid)
  --threads int         Number of threads. Default: 1
  --restart_times RESTART_TIMES
                        number of times to restart failing jobs (default 0)
  -n                    Dry run

```

## Graph

![](graph.svg)

**n.b.** `freebayes` doesn't print in the `snakemake` rulegraph, because it comes after a [checkpoint rule](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#data-dependent-conditional-execution). The input is from `markdup` and `generate_regions`.
