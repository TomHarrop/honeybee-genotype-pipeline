#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(data.table)
library(ggplot2)

lmiss_file <- args[[1]]

lmiss <- fread(lmiss_file)

gp <- ggplot(lmiss, aes(x = F_MISS)) +
    xlab("Number of loci") +
    geom_histogram(bins=50) +
    geom_vline(xintercept = 0.1)

ggsave(args[[2]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()

