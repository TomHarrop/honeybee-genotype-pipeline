#!/usr/bin/env python3

import shutil

# dev
# import snakemake
# r = snakemake.io.glob_wildcards(
#   'output/010_genotypes/aeth/030_calls/regions/{region}.vcf').region
# vcf_files = snakemake.io.expand('output/010_genotypes/aeth/030_calls/regions/{region}.vcf',
#                   region=r)
# cat_file = 'test.vcf'

vcf_files = snakemake.input
cat_file = snakemake.output[0]

with open(cat_file, 'wb') as wfd:
    for f in vcf_files:
        with open(f, 'rb') as fd:
            shutil.copyfileobj(fd, wfd)
