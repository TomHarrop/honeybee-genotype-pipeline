## honeybee genotype pipeline

Preconfigured pipeline for converting Illumina reads into VCF for *Apis mellifera*.

- Strict barcode check (the barcode sequence in the Illumina header is `i7seq+rc(r5seq)` where the seqs are listed in SampleSheet_MiSeq_E7600.csv from NEB)

```bash
reformat.sh \
    barcodefilter=t \
    barcodes='TCCGCGAA+GTCAGTAC' \
    in=BB29_pools_R1.fq.gz \
    in2=BB29_pools_R2.fq.gz \
    out=stdout.fastq \
    > /dev/null
```

- Filter contaminants and trim adaptors, check pairing
- Map against reference genome
- Call SNPs with `freebayes`

In another pipeline:

- Filter haplotypes on the individual drones.
- Use whatshap to set this as a haplotype and phase the other.

**Install**.

**Software dependencies**.

**Input**:

- `samples.csv`: a four-column CSV file containing sample name, barcode, path to R1, path to R2, and a metadata column
- `config.yaml`
- 
