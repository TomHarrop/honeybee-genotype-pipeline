#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(data.table)
library(ggplot2)

frq_file <- args[[1]]

frq <- fread(frq_file,
           fill = TRUE)

frq[, maf := min(`{FREQ}`,
                 V6, na.rm = TRUE),
    by = .(CHROM, POS)]

gp <- ggplot(frq, aes(x = maf)) +
    xlab("Minor allele frequency") + 
    ylab("Number of loci") + 
    geom_vline(xintercept = 0.1) +
    geom_histogram(binwidth = 0.01)

ggsave(args[[2]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()
